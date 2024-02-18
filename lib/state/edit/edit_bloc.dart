import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/state/edit/edit_event.dart';
import 'package:noted_app/state/edit/edit_state.dart';
import 'package:noted_app/state/edit/plugins/cookbook/cookbook_edit_bloc.dart';
import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/util/debouncer.dart';
import 'package:noted_app/util/environment/environment.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

const _updateDebounceMs = 250;

class EditBloc extends NotedBloc<EditEvent, EditState> {
  final NotesRepository _notes;
  final AuthRepository _auth;
  late final StreamSubscription<UserModel> _userSubscription;
  StreamSubscription<NoteModel>? _noteSubscription;

  final _updateMap = <NoteField, NoteFieldValue>{};
  EditUpdateHandler? _updateHandler;

  EditBloc.load({
    required String noteId,
    NotesRepository? notesRepository,
    AuthRepository? authRepository,
    int updateDebounceMs = _updateDebounceMs,
  })  : _notes = notesRepository ?? locator<NotesRepository>(),
        _auth = authRepository ?? locator<AuthRepository>(),
        super(const EditState(note: null), 'edit') {
    _init(updateDebounceMs);
    add(EditLoadEvent(noteId));
  }

  EditBloc.add({
    required NotedPlugin plugin,
    NotesRepository? notesRepository,
    AuthRepository? authRepository,
    int updateDebounceMs = _updateDebounceMs,
  })  : _notes = notesRepository ?? locator<NotesRepository>(),
        _auth = authRepository ?? locator<AuthRepository>(),
        super(const EditState(note: null), 'edit') {
    _init(updateDebounceMs);
    add(EditAddEvent(plugin._emptyModel()));
  }

  void _init(int updateDebounceMs) {
    on<EditAddEvent>(_onAddNote, transformer: restartable());
    on<EditLoadEvent>(_onLoadNote, transformer: restartable());
    on<EditUpdateEvent>(_onUpdateNote);
    on<EditCommitUpdatesEvent>(_onCommitUpdates, transformer: debounced(updateDebounceMs));
    on<EditDeleteEvent>(_onDeleteNote, transformer: restartable());
    on<EditRemoteUpdateEvent>(_onRemoteUpdateNote);
    on<EditRemoteUpdateErrorEvent>(_onRemoteUpdateError);
    on<EditCloseEvent>(_onClose);

    _userSubscription = _auth.userStream.listen((user) {
      if (user.isEmpty) {
        add(const EditCloseEvent());
      }
    });
  }

  Future _subscribeNote(String noteId, Emitter<EditState> emit) async {
    _noteSubscription?.cancel();
    _noteSubscription = null;

    final stream = await _notes.subscribeNote(userId: _auth.currentUser.id, noteId: noteId);
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

      final note = await _notes.fetchNote(userId: _auth.currentUser.id, noteId: event.id);
      _updateHandler = note.plugin._updateHandler();
      emit(EditState(note: note, status: EditStatus.loaded));

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

      final id = await _notes.addNote(
        userId: _auth.currentUser.id,
        note: event.note.copyWithField(NoteFieldValue(NoteField.lastUpdatedUtc, DateTime.now().toUtc())),
      );

      final note = await _notes.fetchNote(userId: _auth.currentUser.id, noteId: id);
      _updateHandler = note.plugin._updateHandler();
      emit(EditState(note: note, status: EditStatus.loaded));

      await _subscribeNote(id, emit);
    } catch (e) {
      emit(EditState(note: null, status: EditStatus.empty, error: NotedError.fromObject(e)));
    }
  }

  void _onUpdateNote(EditUpdateEvent event, Emitter<EditState> emit) {
    _updateMap[event.update.field] = event.update;
    add(const EditCommitUpdatesEvent());
  }

  Future<void> _onCommitUpdates(EditCommitUpdatesEvent event, Emitter<EditState> emit) async {
    try {
      final note = state.note;

      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_update_failed, message: 'missing auth');
      }

      if (note == null) {
        throw NotedError(ErrorCode.notes_update_failed, message: 'missing note');
      }

      final updates = _updateMap.values.toList();
      _updateMap.clear();
      await _notes.updateFields(userId: _auth.currentUser.id, noteId: note.id, updates: updates);
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
    if (isClosed) {
      return;
    }

    emit(EditState(note: event.note, status: EditStatus.loaded));
    _updateHandler?.run(event.note, this);
  }

  Future<void> _onRemoteUpdateError(EditRemoteUpdateErrorEvent event, Emitter<EditState> emit) async {
    if (isClosed) {
      return;
    }

    emit(EditState(note: state.note, status: EditStatus.loaded, error: event.error));
  }

  Future<void> _onClose(EditCloseEvent event, Emitter<EditState> emit) async {
    emit(const EditState(note: null, status: EditStatus.empty));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _noteSubscription?.cancel();
    return super.close();
  }
}

extension on NotedPlugin {
  // coverage:ignore-start
  NoteModel _emptyModel() {
    return switch (this) {
      NotedPlugin.notebook => NoteModel.empty(NotedPlugin.notebook),
      NotedPlugin.cookbook => NoteModel.empty(NotedPlugin.cookbook),
      NotedPlugin.climbing => NoteModel.empty(NotedPlugin.climbing),
    };
  }
  // coverage:ignore-end

  EditUpdateHandler? _updateHandler() {
    // coverage:ignore-start codecov bug
    return switch (this) {
      // coverage:ignore-end codecov bug
      NotedPlugin.cookbook => CookbookEditUpdateHandler(),
      _ => null,
    };
  }
}

abstract class EditUpdateHandler {
  const EditUpdateHandler();

  void run(NoteModel updated, EditBloc bloc);
}
