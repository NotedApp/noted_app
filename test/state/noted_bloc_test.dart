import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/logging/noted_logger.dart';

sealed class _TestEvent extends NotedEvent {}

class _AddEvent extends _TestEvent implements TrackableEvent {}

class _SubtractEvent extends _TestEvent {}

class _ErrorEvent extends _TestEvent {}

class NotedBlocImpl extends NotedBloc<_TestEvent, int> {
  NotedBlocImpl() : super(0, 'test') {
    on<_AddEvent>((event, emit) => emit(state + 1));
    on<_SubtractEvent>((event, emit) => emit(state - 1));
    on<_ErrorEvent>((event, emit) => addError(StateError('test error event received')));
  }
}

class _MockLogger extends Mock implements NotedLogger {}

void main() {
  _MockLogger logger = _MockLogger();
  locator.registerSingleton<NotedLogger>(logger);

  group('NotedBloc', () {
    setUp(() async {
      reset(logger);
    });

    blocTest(
      'logs transitions',
      build: NotedBlocImpl.new,
      act: (bloc) => bloc.add(_AddEvent()),
      expect: () => [1],
      verify: (_) => verify(
        () => logger.logBloc(
          name: 'transition',
          bloc: 'test',
          params: captureAny(named: 'params'),
        ),
      ).called(1),
    );

    blocTest(
      'logs bloc errors',
      build: NotedBlocImpl.new,
      act: (bloc) => bloc.add(_ErrorEvent()),
      expect: () => [],
      verify: (_) => verify(
        () => logger.logBloc(
          name: 'error',
          bloc: 'test',
          params: captureAny(named: 'params'),
        ),
      ).called(1),
    );
  });
}
