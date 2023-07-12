import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/logging/noted_logger.dart';

typedef NotedMiddleware<Event> = void Function(Event);

abstract class NotedEvent {
  const NotedEvent();
}

abstract class TrackableEvent {}

abstract class NotedBloc<Event extends NotedEvent, State> extends Bloc<Event, State> {
  final String _type;
  late final NotedLogger _logger;

  NotedBloc(super.initialState, this._type) {
    _logger = locator<NotedLogger>();
  }

  @override
  void onTransition(Transition<Event, State> transition) {
    super.onTransition(transition);

    if (transition.event is TrackableEvent) {
      _logger.log(
        name: '$_type-bloc-transition',
        params: {
          'from': transition.currentState,
          'event': transition.event,
          'to': transition.nextState,
        },
      );
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);

    _logger.log(
      name: '$_type-bloc-error',
      params: {'error': error},
    );
  }
}
