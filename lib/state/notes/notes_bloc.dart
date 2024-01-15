import 'dart:async';
import 'dart:collection';

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
  final NotesFilter? _filter;
  final NotesRepository _notes;
  final AuthRepository _auth;
  late final StreamSubscription<UserModel> _userSubscription;
  StreamSubscription<List<NoteModel>>? _notesSubscription;

  NotesBloc({
    NotesFilter? filter,
    NotesRepository? notesRepository,
    AuthRepository? authRepository,
  })  : _filter = filter,
        _notes = notesRepository ?? locator<NotesRepository>(),
        _auth = authRepository ?? locator<AuthRepository>(),
        super(const NotesState.loading(), 'notes') {
    on<NotesSubscribeEvent>(_onSubscribeNotes, transformer: restartable());
    on<NotesUpdateEvent>(_onUpdateNotes);
    on<NotesUpdateErrorEvent>(_onUpdateError);
    on<NotesDeleteEvent>(_onDelete);
    on<NotesResetEvent>(_onReset);

    _userSubscription = _auth.userStream.listen((user) {
      if (user.isEmpty) {
        add(NotesResetEvent());
      } else {
        add(NotesSubscribeEvent());
      }
    });
  }

  Future<void> _onSubscribeNotes(NotesSubscribeEvent event, Emitter<NotesState> emit) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_subscribe_failed, message: 'missing auth');
      }

      _notesSubscription?.cancel();
      _notesSubscription = null;

      emit(const NotesState.loading());

      _notesSubscription = (await _notes.subscribeNotes(userId: _auth.currentUser.id, filter: _filter)).listen((event) {
        add(NotesUpdateEvent(event));
      }, onError: (e) {
        add(NotesUpdateErrorEvent(NotedError.fromObject(e)));
      });
    } catch (e) {
      emit(NotesState.error(error: NotedError.fromObject(e)));
    }
  }

  Future<void> _onUpdateNotes(NotesUpdateEvent event, Emitter<NotesState> emit) async {
    if (event.notes.isEmpty) {
      emit(const NotesState.empty());
    } else {
      emit(
        NotesState.success(
          notes: HashMap.fromEntries(
            event.notes.map((model) => MapEntry(model.id, model)),
          ),
        ),
      );
    }
  }

  Future<void> _onUpdateError(NotesUpdateErrorEvent event, Emitter<NotesState> emit) async {
    emit(NotesState.success(notes: state.notes, error: event.error));
  }

  Future<void> _onDelete(NotesDeleteEvent event, Emitter<NotesState> emit) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_delete_failed, message: 'missing auth');
      }

      await _notes.deleteNotes(userId: _auth.currentUser.id, noteIds: event.noteIds);
    } catch (e) {
      emit(NotesState.success(notes: state.notes, error: NotedError.fromObject(e)));
    }
  }

  Future<void> _onReset(NotesResetEvent event, Emitter<NotesState> emit) async {
    emit(const NotesState.loading());

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
