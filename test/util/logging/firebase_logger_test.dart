import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/util/logging/firebase_logger.dart';

class _MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

void main() {
  final Map<String, Object?> defaults = {
    'test-default': 0,
  };

  final Map<String, Object?> params = {
    'test-param-0': 10,
    'test-param-1': 'test',
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

    test('logs to firebase with params', () {
      logger.log(name: 'test-event', params: params);

      verify(() => analytics.logEvent(name: 'test-event', parameters: params)).called(1);
    });
  });
}
