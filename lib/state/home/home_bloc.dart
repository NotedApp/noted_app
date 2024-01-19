import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/state/home/home_event.dart';
import 'package:noted_app/state/home/home_state.dart';
import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/errors/noted_exception.dart';

class HomeBloc extends NotedBloc<HomeEvent, HomeState> {
  final NotesRepository _notes;
  final AuthRepository _auth;

  HomeBloc({
    NotesRepository? notesRepository,
    AuthRepository? authRepository,
  })  : _notes = notesRepository ?? locator<NotesRepository>(),
        _auth = authRepository ?? locator<AuthRepository>(),
        super(const HomeState(selectedIds: {}), 'home') {
    on<HomeToggleSelectionEvent>(_onToggleSelection);
    on<HomeUpdateAvailableEvent>(_onUpdateAvailable);
    on<HomeResetSelectionsEvent>(_onResetSelections);
    on<HomeDeleteSelectionsEvent>(_onHomeDeleteSelections);
  }

  void _onToggleSelection(HomeToggleSelectionEvent event, Emitter<HomeState> emit) {
    final updated = state.selectedIds.toSet();
    if (!updated.remove(event.id)) {
      updated.add(event.id);
    }

    emit(HomeState(selectedIds: updated));
  }

  void _onUpdateAvailable(HomeUpdateAvailableEvent event, Emitter<HomeState> emit) {
    emit(HomeState(selectedIds: state.selectedIds.intersection(event.availableIds)));
  }

  void _onResetSelections(HomeResetSelectionsEvent event, Emitter<HomeState> emit) {
    emit(const HomeState(selectedIds: {}));
  }

  Future<void> _onHomeDeleteSelections(HomeDeleteSelectionsEvent event, Emitter<HomeState> emit) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.notes_delete_failed, message: 'missing auth');
      }

      await _notes.deleteNotes(userId: _auth.currentUser.id, noteIds: state.selectedIds.toList());
      emit(const HomeState(selectedIds: {}));
    } catch (e) {
      emit(HomeState(selectedIds: state.selectedIds, error: NotedError.fromObject(e)));
    }
  }
}
