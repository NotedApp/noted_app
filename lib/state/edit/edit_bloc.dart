import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/state/edit/edit_event.dart';
import 'package:noted_app/state/edit/edit_state.dart';
import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';
import 'package:rxdart/rxdart.dart';

const int _defaultUpdateDebounceMs = 250;

class EditBloc extends NotedBloc<EditEvent, EditState> {
  final int _updateDebounceMs;
  final NotesRepository _notes;
  final AuthRepository _auth;
  late final StreamSubscription<UserModel> _userSubscription;
  StreamSubscription<NoteModel>? _noteSubscription;

  EditBloc({
    required String noteId,
    NotesRepository? notesRepository,
    AuthRepository? authRepository,
    int? updateDebounceMs,
  })  : _notes = notesRepository ?? locator<NotesRepository>(),
        _auth = authRepository ?? locator<AuthRepository>(),
        _updateDebounceMs = updateDebounceMs ?? _defaultUpdateDebounceMs,
        super(const EditState(note: null), 'note') {
    _init();
    add(EditLoadEvent(noteId));
  }

  EditBloc.add({
    required NotedPlugin plugin,
    NotesRepository? notesRepository,
    AuthRepository? authRepository,
    int? updateDebounceMs,
  })  : _notes = notesRepository ?? locator<NotesRepository>(),
        _auth = authRepository ?? locator<AuthRepository>(),
        _updateDebounceMs = updateDebounceMs ?? _defaultUpdateDebounceMs,
        super(const EditState(note: null), 'note') {
    _init();

    // coverage:ignore-start
    NoteModel model = switch (plugin) {
      NotedPlugin.notebook => NotebookNoteModel.empty(),
      NotedPlugin.cookbook => CookbookNoteModel.empty(),
    };
    // coverage:ignore-end

    add(EditAddEvent(model));
  }

  void _init() {
    on<EditAddEvent>(_onAddNote, transformer: restartable());
    on<EditLoadEvent>(_onLoadNote, transformer: restartable());
    on<EditDeleteEvent>(_onDeleteNote, transformer: restartable());
    on<EditRemoteUpdateEvent>(_onRemoteUpdateNote);
    on<EditRemoteUpdateErrorEvent>(_onRemoteUpdateError);
    on<EditCloseEvent>(_onClose);

    on<EditUpdateEvent>(_onUpdateNote, transformer: (updates, mapper) {
      return updates.debounceTime(Duration(milliseconds: _updateDebounceMs)).switchMap(mapper);
    });

    on<EditToggleHiddenEvent>(_onToggleHidden);

    _userSubscription = _auth.userStream.listen((user) {
      if (user.isEmpty) {
        add(const EditCloseEvent());
      }
    });
  }

  Future _subscribeNote(String noteId, Emitter<EditState> emit) async {
    _noteSubscription?.cancel();
    _noteSubscription = null;

    Stream<NoteModel> stream = await _notes.subscribeNote(userId: _auth.currentUser.id, noteId: noteId);
    _noteSubscription = stream.listen((event) {
      add(EditRemoteUpdateEvent(event));
    }, onError: (e) {
      add(EditRemoteUpdateErrorEvent(NotedError.fromObject(e)));
    });
  }

  Future<void> _onLoadNote(EditLoadEvent event, Emitter<EditState> emit) async {
    try {
      if (state.status != EditStatus.initial) {
        return;
      }

      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_subscribe_failed, message: 'missing auth');
      }

      emit(EditState(note: state.note, status: EditStatus.loading));
      await _subscribeNote(event.id, emit);
    } catch (e) {
      emit(EditState(note: null, status: EditStatus.empty, error: NotedError.fromObject(e)));
    }
  }

  Future<void> _onAddNote(EditAddEvent event, Emitter<EditState> emit) async {
    try {
      if (state.status != EditStatus.initial) {
        return;
      }

      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_add_failed, message: 'missing auth');
      }

      emit(EditState(note: state.note, status: EditStatus.loading));
      String id = await _notes.addNote(userId: _auth.currentUser.id, note: event.note);
      await _subscribeNote(id, emit);
    } catch (e) {
      emit(EditState(note: null, status: EditStatus.empty, error: NotedError.fromObject(e)));
    }
  }

  Future<void> _onUpdateNote(EditUpdateEvent event, Emitter<EditState> emit) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_update_failed, message: 'missing auth');
      }

      await _notes.updateNote(
        userId: _auth.currentUser.id,
        note: event.note.copyWith(lastUpdatedUtc: DateTime.now().toUtc()),
      );
    } catch (e) {
      emit(EditState(note: state.note, status: state.status, error: NotedError.fromObject(e)));
    }
  }

  Future<void> _onToggleHidden(EditToggleHiddenEvent event, Emitter<EditState> emit) async {
    try {
      final note = state.note;

      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_update_failed, message: 'missing auth');
      }

      if (note == null) {
        throw NotedError(ErrorCode.notes_update_failed, message: 'missing note');
      }

      await _notes.updateNote(
        userId: _auth.currentUser.id,
        note: note.copyWith(hidden: !note.hidden),
      );
    } catch (e) {
      emit(EditState(note: state.note, status: state.status, error: NotedError.fromObject(e)));
    }
  }

  Future<void> _onDeleteNote(EditDeleteEvent event, Emitter<EditState> emit) async {
    try {
      if (state.status != EditStatus.loaded) {
        return;
      }

      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_update_failed, message: 'missing auth'); // coverage:ignore-line
      }

      emit(EditState(note: state.note, status: EditStatus.deleting));
      await _notes.deleteNote(userId: _auth.currentUser.id, noteId: state.note?.id ?? '');
      emit(const EditState(note: null, status: EditStatus.deleted));
    } catch (e) {
      emit(EditState(note: state.note, status: state.status, error: NotedError.fromObject(e)));
    }
  }

  Future<void> _onRemoteUpdateNote(EditRemoteUpdateEvent event, Emitter<EditState> emit) async {
    emit(EditState(note: event.note, status: EditStatus.loaded));
  }

  Future<void> _onRemoteUpdateError(EditRemoteUpdateErrorEvent event, Emitter<EditState> emit) async {
    emit(EditState(note: state.note, status: EditStatus.loaded, error: event.error));
  }

  Future<void> _onClose(EditCloseEvent event, Emitter<EditState> emit) async {
    emit(const EditState(note: null, status: EditStatus.empty));
  }

  // coverage:ignore-start
  @override
  Future<void> close() {
    _userSubscription.cancel();
    _noteSubscription?.cancel();
    return super.close();
  }
  // coverage:ignore-end
}
