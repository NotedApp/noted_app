import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/state/notes/notes_event.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

class NotesBloc extends NotedBloc<NotesEvent, NotesState> {
  final NotesRepository _notes;
  final AuthRepository _auth;
  late final StreamSubscription<UserModel> _userSubscription;
  StreamSubscription<List<NoteModel>>? _notesSubscription;

  NotesBloc({NotesRepository? notesRepository, AuthRepository? authRepository})
      : _notes = notesRepository ?? locator<NotesRepository>(),
        _auth = authRepository ?? locator<AuthRepository>(),
        super(NotesState.loading(), 'notes') {
    on<NotesSubscribeEvent>(_onSubscribeNotes, transformer: restartable());
    on<NotesUpdateEvent>(_onUpdateNotes);
    on<NotesUpdateErrorEvent>(_onUpdateError);
    on<NotesResetEvent>(_onReset);

    _userSubscription = _auth.userStream.listen((user) {
      if (user.isEmpty) {
        add(NotesResetEvent());
      } else {
        add(NotesSubscribeEvent());
      }
    });
  }

  void _onSubscribeNotes(NotesSubscribeEvent event, Emitter<NotesState> emit) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_subscribe_failed, message: 'missing auth');
      }

      _notesSubscription?.cancel();
      _notesSubscription = null;

      emit(NotesState.loading());

      _notesSubscription = (await _notes.subscribeNotes(userId: _auth.currentUser.id)).listen((event) {
        add(NotesUpdateEvent(event));
      }, onError: (e) {
        add(NotesUpdateErrorEvent(NotedError.fromObject(e)));
      });
    } catch (e) {
      emit(NotesState.error(error: NotedError.fromObject(e)));
    }
  }

  void _onUpdateNotes(NotesUpdateEvent event, Emitter<NotesState> emit) async {
    if (event.notes.isEmpty) {
      emit(NotesState.empty());
    } else {
      emit(NotesState.success(notes: event.notes));
    }
  }

  void _onUpdateError(NotesUpdateErrorEvent event, Emitter<NotesState> emit) async {
    emit(NotesState.success(notes: state.notes, error: event.error));
  }

  void _onReset(NotesResetEvent event, Emitter<NotesState> emit) async {
    emit(NotesState.loading());

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
