import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/home/home_event.dart';
import 'package:noted_app/state/home/home_state.dart';
import 'package:noted_app/state/noted_bloc.dart';

class HomeBloc extends NotedBloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(selectedIds: {}), 'home') {
    on<HomeToggleSelectionEvent>(_onToggleSelection);
    on<HomeUpdateAvailableEvent>(_onUpdateAvailable);
    on<HomeResetSelectionsEvent>(_onResetSelections);
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
}
