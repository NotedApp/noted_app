import 'package:flutter/foundation.dart';

/// A class that handles crash reporting.
abstract class NotedCrashHandler {
  // Logs a flutter error.
  void handleFlutterError(FlutterErrorDetails details);

  // Logs an async error.
  bool handleAsyncError(Object object, StackTrace stack);
}
