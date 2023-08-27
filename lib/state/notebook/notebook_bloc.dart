import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/notebook/notebook_repository.dart';
import 'package:noted_app/state/notebook/notebook_event.dart';
import 'package:noted_app/state/notebook/notebook_state.dart';
import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

class NotebookBloc extends NotedBloc<NotebookEvent, NotebookState> {
  final NotebookRepository _notebook;
  final AuthRepository _auth;
  late final StreamSubscription<NotedUser> _userSubscription;

  NotebookBloc({NotebookRepository? notebookRepository, AuthRepository? authRepository})
      : _notebook = notebookRepository ?? locator<NotebookRepository>(),
        _auth = authRepository ?? locator<AuthRepository>(),
        super(NotebookState(), 'notebook') {
    on<NotebookLoadNotesEvent>(_onLoadNotes);
    on<NotebookAddNoteEvent>(_onAddNote);
    on<NotebookUpdateNoteEvent>(_onUpdateNote);
    on<NotebookDeleteNoteEvent>(_onDeleteNote);
    on<NotebookResetEvent>(_onReset);

    _userSubscription = _auth.userStream.listen((user) {
      if (user.isEmpty) {
        add(NotebookResetEvent());
      } else {
        add(NotebookLoadNotesEvent());
      }
    });
  }

  void _onLoadNotes(NotebookLoadNotesEvent event, Emitter<NotebookState> emit) async {
    if (state.status == NotebookStatus.loading) {
      return;
    }

    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedException(ErrorCode.notebook_subscribe_failed, message: 'missing auth');
      }

      emit(NotebookState(status: NotebookStatus.loading));
      // List<NotebookNote> notes = await _notebook.fetchNotes(userId: _auth.currentUser.id);
      emit(NotebookState(notes: []));
    } catch (e) {
      emit(NotebookState(error: NotedException.fromObject(e)));
    }
  }

  void _onAddNote(NotebookAddNoteEvent event, Emitter<NotebookState> emit) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedException(ErrorCode.notebook_add_failed, message: 'missing auth');
      }

      await _notebook.addNote(userId: _auth.currentUser.id, note: event.note);
      add(NotebookLoadNotesEvent());
    } catch (e) {
      emit(NotebookState(error: NotedException.fromObject(e)));
    }
  }

  void _onUpdateNote(NotebookUpdateNoteEvent event, Emitter<NotebookState> emit) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedException(ErrorCode.notebook_update_failed, message: 'missing auth');
      }

      await _notebook.updateNote(userId: _auth.currentUser.id, note: event.note);

      int index = state.notes.indexWhere((note) => note.id == event.note.id);
      if (index < 0) {
        throw NotedException(ErrorCode.notebook_update_failed, message: 'missing note in state');
      }

      List<NotebookNote> updated = [...state.notes];
      updated[index] = event.note;
      emit(NotebookState(notes: updated));
    } catch (e) {
      emit(NotebookState(error: NotedException.fromObject(e)));
    }
  }

  void _onDeleteNote(NotebookDeleteNoteEvent event, Emitter<NotebookState> emit) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedException(ErrorCode.notebook_delete_failed, message: 'missing auth');
      }

      await _notebook.deleteNote(userId: _auth.currentUser.id, noteId: event.noteId);
      add(NotebookLoadNotesEvent());
    } catch (e) {
      emit(NotebookState(error: NotedException.fromObject(e)));
    }
  }

  void _onReset(NotebookResetEvent event, Emitter<NotebookState> emit) async {
    emit(NotebookState());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
