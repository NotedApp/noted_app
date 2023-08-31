import 'package:flutter/src/foundation/assertions.dart';
import 'package:noted_app/util/errors/noted_crash_handler.dart';
import 'dart:developer' as developer;

// coverage:ignore-file
class LocalCrashHandler extends NotedCrashHandler {
  @override
  void handleFlutterError(FlutterErrorDetails details) {
    developer.log('flutter error', error: details.exception, stackTrace: details.stack);
  }

  @override
  bool handleAsyncError(Object object, StackTrace stack) {
    developer.log('async error', error: object, stackTrace: stack);
    return true;
  }
}
