import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:noted_app/util/logging/noted_logger.dart';

class FirebaseLogger extends NotedLogger {
  final FirebaseAnalytics _analytics;

  FirebaseLogger({FirebaseAnalytics? analytics}) : _analytics = analytics ?? FirebaseAnalytics.instance;

  @override
  void setDefaultParams({required Map<String, Object?> params}) {
    _analytics.setDefaultEventParameters(params);
  }

  @override
  void log({required String name, Map<String, Object?> params = const {}}) {
    _analytics.logEvent(name: name, parameters: params);
  }
}
