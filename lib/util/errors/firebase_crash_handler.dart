import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/src/foundation/assertions.dart';
import 'package:noted_app/util/errors/noted_crash_handler.dart';

// coverage:ignore-file
class FirebaseCrashHandler extends NotedCrashHandler {
  final FirebaseCrashlytics _crashlytics;

  FirebaseCrashHandler({FirebaseCrashlytics? crashlytics}) : _crashlytics = crashlytics ?? FirebaseCrashlytics.instance;

  @override
  void handleFlutterError(FlutterErrorDetails details) {
    _crashlytics.recordFlutterFatalError(details);
  }

  @override
  bool handleAsyncError(Object object, StackTrace stack) {
    _crashlytics.recordError(object, stack, fatal: true);
    return true;
  }
}
