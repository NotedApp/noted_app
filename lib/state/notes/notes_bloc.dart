import 'dart:async';
import 'dart:collection';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/state/notes/notes_event.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/util/environment/environment.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

class NotesBloc extends NotedBloc<NotesEvent, NotesState> {
  final NotesFilter? _filter;
  final NotesRepository _notes;
  final AuthRepository _auth;
  late final StreamSubscription<UserModel> _userSubscription;
  StreamSubscription<List<NoteModel>>? _notesSubscription;

  NotesBloc({
    String page = 'notes',
    NotesFilter? filter,
    NotesRepository? notesRepository,
    AuthRepository? authRepository,
  })  : _filter = filter,
        _notes = notesRepository ?? locator<NotesRepository>(),
        _auth = authRepository ?? locator<AuthRepository>(),
        super(const NotesState.loading(), page) {
    on<NotesSubscribeEvent>(_onSubscribeNotes, transformer: restartable());
    on<NotesUpdateEvent>(_onUpdateNotes);
    on<NotesUpdateErrorEvent>(_onUpdateError);
    on<NotesDeleteEvent>(_onDelete);
    on<NotesToggleSelectionEvent>(_onToggleSelection);
    on<NotesResetSelectionsEvent>(_onResetSelections);
    on<NotesDeleteSelectionsEvent>(_onDeleteSelections);
    on<NotesResetEvent>(_onReset);

    _userSubscription = _auth.userStream.listen((user) {
      if (user.isEmpty) {
        add(const NotesResetEvent());
      } else {
        add(const NotesSubscribeEvent());
      }
    });

    if (_auth.currentUser.isNotEmpty) {
      add(const NotesSubscribeEvent());
    }
  }

  Future<void> _onSubscribeNotes(NotesSubscribeEvent event, Emitter<NotesState> emit) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_subscribe_failed, message: 'missing auth');
      }

      _notesSubscription?.cancel();
      _notesSubscription = null;

      emit(const NotesState.loading());

      final notes = await _notes.fetchNotes(userId: _auth.currentUser.id, filter: _filter);
      if (notes.isEmpty) {
        emit(const NotesState.empty());
      } else {
        emit(NotesState.success(notes: {for (final note in notes) note.id: note}));
      }

      final stream = await _notes.subscribeNotes(userId: _auth.currentUser.id, filter: _filter);
      _notesSubscription = stream.listen((event) {
        add(NotesUpdateEvent(event));
      }, onError: (e) {
        add(NotesUpdateErrorEvent(NotedError.fromObject(e)));
      });
    } catch (e) {
      emit(NotesState.error(error: NotedError.fromObject(e)));
    }
  }

  Future<void> _onUpdateNotes(NotesUpdateEvent event, Emitter<NotesState> emit) async {
    if (isClosed) {
      return;
    }

    if (event.notes.isEmpty) {
      emit(const NotesState.empty());
    } else {
      emit(
        NotesState.success(
          notes: HashMap.fromEntries(event.notes.map((model) => MapEntry(model.id, model))),
          selectedIds: state.selectedIds.intersection(event.notes.map((model) => model.id).toSet()),
        ),
      );
    }
  }

  Future<void> _onUpdateError(NotesUpdateErrorEvent event, Emitter<NotesState> emit) async {
    if (isClosed) {
      return;
    }

    switch (state.status) {
      case NotesStatus.loaded:
        emit(NotesState.success(notes: state.notes, selectedIds: state.selectedIds, error: event.error));
      default:
        emit(NotesState.error(error: event.error)); // coverage:ignore-line
    }
  }

  Future<void> _onDelete(NotesDeleteEvent event, Emitter<NotesState> emit) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_delete_failed, message: 'missing auth');
      }

      await _notes.deleteNotes(userId: _auth.currentUser.id, noteIds: event.noteIds);
    } catch (e) {
      emit(NotesState.success(notes: state.notes, selectedIds: state.selectedIds, error: NotedError.fromObject(e)));
    }
  }

  void _onToggleSelection(NotesToggleSelectionEvent event, Emitter<NotesState> emit) {
    if (state.status != NotesStatus.loaded) {
      return;
    }

    final updated = state.selectedIds.toSet();
    if (!updated.remove(event.id) && state.sortedNoteIds.contains(event.id)) {
      updated.add(event.id);
    }

    emit(NotesState.success(notes: state.notes, selectedIds: updated));
  }

  void _onResetSelections(NotesResetSelectionsEvent event, Emitter<NotesState> emit) {
    if (state.status != NotesStatus.loaded) {
      return;
    }

    emit(NotesState.success(notes: state.notes));
  }

  Future<void> _onDeleteSelections(NotesDeleteSelectionsEvent event, Emitter<NotesState> emit) async {
    if (state.status != NotesStatus.loaded) {
      return;
    }

    add(NotesDeleteEvent(state.selectedIds.toList()));
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
