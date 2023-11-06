import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/state/edit/edit_event.dart';
import 'package:noted_app/state/edit/edit_state.dart';
import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

class EditBloc extends NotedBloc<EditEvent, EditState> {
  final NotesRepository _notes;
  final AuthRepository _auth;
  late final StreamSubscription<UserModel> _userSubscription;
  StreamSubscription<NoteModel>? _noteSubscription;

  EditBloc({required String? noteId, NotesRepository? notesRepository, AuthRepository? authRepository})
      : _notes = notesRepository ?? locator<NotesRepository>(),
        _auth = authRepository ?? locator<AuthRepository>(),
        super(EditState(note: null), 'note') {
    on<EditAddEvent>(_onAddNote);
    on<EditLoadEvent>(_onLoadNote);
    on<EditUpdateEvent>(_onUpdateNote);
    on<EditDeleteEvent>(_onDeleteNote);
    on<EditRemoteUpdateEvent>(_onRemoteUpdateNote);
    on<EditRemoteUpdateErrorEvent>(_onRemoteUpdateError);
    on<EditCloseEvent>(_onClose);

    _userSubscription = _auth.userStream.listen((user) {
      if (user.isEmpty) {
        add(EditCloseEvent());
      }
    });

    if (noteId == null) {
      add(EditAddEvent(NotebookNoteModel.empty()));
    } else {
      add(EditLoadEvent(noteId));
    }
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

  void _onLoadNote(EditLoadEvent event, Emitter<EditState> emit) async {
    try {
      if (state.status != EditStatus.initial) {
        throw NotedError(ErrorCode.notes_subscribe_failed, message: 'invalid status: ${state.status}');
      }

      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_subscribe_failed, message: 'missing auth');
      }

      emit(EditState(note: state.note, status: EditStatus.loading));
      await _subscribeNote(event.id, emit);
    } catch (e) {
      emit(EditState(note: null, status: EditStatus.loaded, error: NotedError.fromObject(e)));
    }
  }

  void _onAddNote(EditAddEvent event, Emitter<EditState> emit) async {
    try {
      if (state.status != EditStatus.initial) {
        throw NotedError(ErrorCode.notes_add_failed, message: 'invalid status: ${state.status}');
      }

      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_add_failed, message: 'missing auth');
      }

      emit(EditState(note: state.note, status: EditStatus.loading));
      String id = await _notes.addNote(userId: _auth.currentUser.id, note: event.note);
      await _subscribeNote(id, emit);
    } catch (e) {
      emit(EditState(note: null, status: EditStatus.loaded, error: NotedError.fromObject(e)));
    }
  }

  void _onUpdateNote(EditUpdateEvent event, Emitter<EditState> emit) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_update_failed, message: 'missing auth');
      }

      emit(EditState(note: state.note, status: EditStatus.updating));
      await _notes.updateNote(userId: _auth.currentUser.id, note: event.note);
    } catch (e) {
      emit(EditState(note: state.note, status: EditStatus.loaded, error: NotedError.fromObject(e)));
    }
  }

  void _onDeleteNote(EditDeleteEvent event, Emitter<EditState> emit) async {
    try {
      if (![EditStatus.loaded, EditStatus.updating].contains(state.status)) {
        throw NotedError(ErrorCode.notes_delete_failed, message: 'invalid status: ${state.status}');
      }

      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_delete_failed, message: 'missing auth');
      }

      emit(EditState(note: state.note, status: EditStatus.deleting));
      await _notes.deleteNote(userId: _auth.currentUser.id, noteId: state.note?.id ?? '');
      emit(EditState(note: null, status: EditStatus.deleted));
    } catch (e) {
      emit(EditState(note: state.note, status: EditStatus.loaded, error: NotedError.fromObject(e)));
    }
  }

  void _onRemoteUpdateNote(EditRemoteUpdateEvent event, Emitter<EditState> emit) async {
    emit(EditState(note: event.note, status: EditStatus.loaded));
  }

  void _onRemoteUpdateError(EditRemoteUpdateErrorEvent event, Emitter<EditState> emit) async {
    emit(EditState(note: state.note, status: EditStatus.loaded, error: event.error));
  }

  void _onClose(EditCloseEvent event, Emitter<EditState> emit) async {
    emit(EditState(note: null, status: EditStatus.loaded));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _noteSubscription?.cancel();
    return super.close();
  }
}
