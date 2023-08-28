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
        super(NotebookState(notes: const []), 'notebook') {
    on<NotebookSubscribeNotesEvent>(_onSubscribeNotes);
    on<NotebookUpdateNotesEvent>(_onUpdateNotes);
    on<NotebookUpdateErrorEvent>(_onUpdateError);
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

      emit(NotebookState(notes: const [], status: NotebookStatus.loading));

      _notesSubscription = (await _notebook.subscribeNotes(userId: _auth.currentUser.id)).listen((event) {
        add(NotebookUpdateNotesEvent(event));
      }, onError: (e) {
        add(NotebookUpdateErrorEvent(NotedException.fromObject(e)));
      });
    } catch (e) {
      emit(NotebookState(notes: state.notes, error: NotedException.fromObject(e)));
    }
  }

  void _onUpdateNotes(NotebookUpdateNotesEvent event, Emitter<NotebookState> emit) async {
    emit(NotebookState(notes: event.notes));
  }

  void _onUpdateError(NotebookUpdateErrorEvent event, Emitter<NotebookState> emit) async {
    emit(NotebookState(notes: state.notes, error: event.error));
  }

  void _onAddNote(NotebookAddNoteEvent event, Emitter<NotebookState> emit) async {
    if (state.status == NotebookStatus.adding) {
      return;
    }

    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedException(ErrorCode.notebook_add_failed, message: 'missing auth');
      }

      emit(NotebookState(notes: state.notes, status: NotebookStatus.adding));
      String id = await _notebook.addNote(userId: _auth.currentUser.id, note: event.note);
      emit(NotebookState(notes: state.notes, added: id));
    } catch (e) {
      emit(NotebookState(notes: state.notes, error: NotedException.fromObject(e)));
    }
  }

  void _onUpdateNote(NotebookUpdateNoteEvent event, Emitter<NotebookState> emit) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedException(ErrorCode.notebook_update_failed, message: 'missing auth');
      }

      await _notebook.updateNote(userId: _auth.currentUser.id, note: event.note);
    } catch (e) {
      emit(NotebookState(notes: state.notes, error: NotedException.fromObject(e)));
    }
  }

  void _onDeleteNote(NotebookDeleteNoteEvent event, Emitter<NotebookState> emit) async {
    if (state.status == NotebookStatus.deleting) {
      return;
    }

    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedException(ErrorCode.notebook_delete_failed, message: 'missing auth');
      }

      emit(NotebookState(notes: state.notes, status: NotebookStatus.deleting));
      await _notebook.deleteNote(userId: _auth.currentUser.id, noteId: event.noteId);
      emit(NotebookState(notes: state.notes, deleted: event.noteId));
    } catch (e) {
      emit(NotebookState(notes: state.notes, error: NotedException.fromObject(e)));
    }
  }

  void _onReset(NotebookResetEvent event, Emitter<NotebookState> emit) async {
    emit(NotebookState(notes: const []));

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
