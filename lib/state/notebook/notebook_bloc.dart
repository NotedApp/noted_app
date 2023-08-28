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
  StreamSubscription<List<NotebookNote>>? _notesSubscription;

  NotebookBloc({NotebookRepository? notebookRepository, AuthRepository? authRepository})
      : _notebook = notebookRepository ?? locator<NotebookRepository>(),
        _auth = authRepository ?? locator<AuthRepository>(),
        super(NotebookState(), 'notebook') {
    on<NotebookSubscribeNotesEvent>(_onSubscribeNotes);
    on<NotebookUpdateNotesEvent>(_onUpdateNotes);
    on<NotebookAddNoteEvent>(_onAddNote);
    on<NotebookUpdateNoteEvent>(_onUpdateNote);
    on<NotebookDeleteNoteEvent>(_onDeleteNote);
    on<NotebookResetEvent>(_onReset);

    _userSubscription = _auth.userStream.listen((user) {
      if (user.isEmpty) {
        add(NotebookResetEvent());
      } else {
        add(NotebookSubscribeNotesEvent());
      }
    });
  }

  void _onSubscribeNotes(NotebookSubscribeNotesEvent event, Emitter<NotebookState> emit) async {
    if (state.status == NotebookStatus.loading) {
      return;
    }

    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedException(ErrorCode.notebook_subscribe_failed, message: 'missing auth');
      }

      _notesSubscription?.cancel();
      _notesSubscription = null;

      emit(NotebookState(status: NotebookStatus.loading));

      _notesSubscription = (await _notebook.subscribeNotes(userId: _auth.currentUser.id)).listen((event) {
        add(NotebookUpdateNotesEvent(event));
      });
    } catch (e) {
      emit(NotebookState(error: NotedException.fromObject(e)));
    }
  }

  void _onUpdateNotes(NotebookUpdateNotesEvent event, Emitter<NotebookState> emit) async {
    emit(NotebookState(notes: event.notes));
  }

  void _onAddNote(NotebookAddNoteEvent event, Emitter<NotebookState> emit) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedException(ErrorCode.notebook_add_failed, message: 'missing auth');
      }

      await _notebook.addNote(userId: _auth.currentUser.id, note: event.note);
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
    } catch (e) {
      emit(NotebookState(error: NotedException.fromObject(e)));
    }
  }

  void _onReset(NotebookResetEvent event, Emitter<NotebookState> emit) async {
    emit(NotebookState());

    _notesSubscription?.cancel();
    _notesSubscription = null;
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _notesSubscription?.cancel();
    return super.close();
  }
}
