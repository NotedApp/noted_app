import 'package:noted_app/state/noted_bloc.dart';

sealed class HomeEvent extends NotedEvent implements TrackableEvent {
  const HomeEvent();
}

class HomeToggleSelectionEvent extends HomeEvent {
  final String id;

  const HomeToggleSelectionEvent(this.id);
}

class HomeUpdateAvailableEvent extends HomeEvent {
  final Set<String> availableIds;

  const HomeUpdateAvailableEvent(this.availableIds);
}

class HomeResetSelectionsEvent extends HomeEvent {}
