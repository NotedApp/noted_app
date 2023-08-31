import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/repository/notebook/local_notebook_repository.dart';
import 'package:noted_app/repository/notebook/notebook_repository.dart';
import 'package:noted_app/repository/settings/local_settings_repository.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/util/environment/environment.dart';
import 'package:noted_app/util/environment/test_firebase_options.dart';
import 'package:noted_app/util/errors/local_crash_handler.dart';
import 'package:noted_app/util/errors/noted_crash_handler.dart';
import 'package:noted_app/util/logging/local_logger.dart';
import 'package:noted_app/util/logging/noted_logger.dart';
import 'package:noted_app/ui/router/noted_router.dart';

import 'test_router.dart';

class UnitTestEnvironment extends Environment {
  @override
  FirebaseOptions get firebaseOptions => TestFirebaseOptions.currentPlatform;

  @override
  NotedCrashHandler get crashHandler => LocalCrashHandler();

  @override
  NotedLogger get logger => LocalLogger();

  @override
  NotedRouter get router => TestRouter();

  @override
  AuthRepository get authRepository => LocalAuthRepository();

  @override
  SettingsRepository get settingsRepository => LocalSettingsRepository();

  @override
  NotebookRepository get notebookRepository => LocalNotebookRepository();
}
