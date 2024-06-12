import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/util/logging/firebase_logger.dart';

class _MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

void main() {
  final Map<String, Object> defaults = {
    'test-default': 0,
  };

  final Map<String, Object> uiParams = {
    'test-param-0': 10,
    'test-param-1': 'test',
  };

  final Map<String, Object> uiResult = {
    'test-param-0': 10,
    'test-param-1': 'test',
    'page': 'test',
  };

  final Map<String, Object> blocParams = {
    'test-param-0': 10,
    'test-param-1': 'test',
  };

  final Map<String, Object> blocResult = {
    'test-param-0': 10,
    'test-param-1': 'test',
    'bloc': 'test',
  };

  final _MockFirebaseAnalytics analytics = _MockFirebaseAnalytics();
  final FirebaseLogger logger = FirebaseLogger(analytics: analytics);

  setUp(() {
    reset(analytics);
    when(() => analytics.setDefaultEventParameters(captureAny())).thenAnswer(Future.value);
    when(
      () => analytics.logEvent(
        name: captureAny(named: 'name'),
        parameters: captureAny(named: 'parameters'),
      ),
    ).thenAnswer(Future.value);
  });

  group('FirebaseLogger', () {
    test('sets default params', () {
      logger.setDefaultParams(params: defaults);

      verify(() => analytics.setDefaultEventParameters(defaults)).called(1);
    });

    test('logs ui to firebase with params', () {
      logger.logUi(name: 'event', page: 'test', params: uiParams);

      verify(() => analytics.logEvent(name: 'test-page-event', parameters: uiResult)).called(1);
    });

    test('logs bloc to firebase with params', () {
      logger.logBloc(name: 'event', bloc: 'test', params: blocParams);

      verify(() => analytics.logEvent(name: 'test-bloc-event', parameters: blocResult)).called(1);
    });
  });
}
