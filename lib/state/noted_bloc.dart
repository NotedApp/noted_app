import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/logging/noted_logger.dart';

typedef NotedMiddleware<Event> = void Function(Event);

abstract class NotedEvent {
  const NotedEvent();
}

abstract class TrackableEvent {}

// This flag enables verbose logging for the Noted Bloc. Please ensure that this flag is only enabled for testing
// purposes, and is disabled when checked in to source control.
const bool _logVerbose = false;

abstract class NotedBloc<Event extends NotedEvent, State> extends Bloc<Event, State> {
  final String _type;
  late final NotedLogger _logger;

  NotedBloc(super.initialState, this._type) {
    _logger = locator<NotedLogger>();
  }

  @override
  void onTransition(Transition<Event, State> transition) {
    super.onTransition(transition);

    Map<String, dynamic> params = {'event': transition.event};

    if (_logVerbose) {
      // coverage:ignore-start
      params.addAll({
        'from': transition.currentState,
        'to': transition.nextState,
      });
      // coverage:ignore-end
    }

    if (transition.event is TrackableEvent) {
      _logger.logBloc(
        name: 'transition',
        bloc: _type,
        params: params,
      );
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);

    _logger.logBloc(
      name: 'error',
      bloc: _type,
      params: {'error': error},
    );
  }
}
