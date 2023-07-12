import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/logging/noted_logger.dart';

typedef NotedMiddleware<Event> = void Function(Event);

abstract class NotedEvent {}

abstract class TrackableEvent {}

abstract class NotedBloc<Event extends NotedEvent, State> extends Bloc<Event, State> {
  final String _type;
  late NotedLogger _logger;

  NotedBloc(super.initialState, this._type) {
    _logger = locator<NotedLogger>();
  }

  @override
  void onTransition(Transition<Event, State> transition) {
    super.onTransition(transition);

    if (Event is TrackableEvent) {
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
}
