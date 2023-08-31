import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/firebase_auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/repository/notebook/firebase_notebook_repository.dart';
import 'package:noted_app/repository/notebook/local_notebook_repository.dart';
import 'package:noted_app/repository/notebook/notebook_repository.dart';
import 'package:noted_app/repository/settings/firebase_settings_repository.dart';
import 'package:noted_app/repository/settings/local_settings_repository.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/environment/test_firebase_options.dart';
import 'package:noted_app/util/errors/firebase_crash_handler.dart';
import 'package:noted_app/util/errors/local_crash_handler.dart';
import 'package:noted_app/util/errors/noted_crash_handler.dart';
import 'package:noted_app/util/logging/firebase_logger.dart';
import 'package:noted_app/util/logging/local_logger.dart';
import 'package:noted_app/util/logging/noted_logger.dart';
import 'package:noted_app/ui/router/noted_go_router.dart';
import 'package:noted_app/ui/router/noted_router.dart';

// coverage:ignore-file
abstract class Environment {
  FirebaseOptions get firebaseOptions;
  NotedCrashHandler get crashHandler;
  NotedLogger get logger;
  NotedRouter get router;
  AuthRepository get authRepository;
  SettingsRepository get settingsRepository;
  NotebookRepository get notebookRepository;

  Future<void> configure({
    FirebaseOptions? firebaseOptions,
    NotedCrashHandler? crashHandler,
    NotedLogger? logger,
    NotedRouter? router,
    AuthRepository? authRepository,
    SettingsRepository? settingsRepository,
    NotebookRepository? notebookRepository,
  }) async {
    await WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: firebaseOptions);

    // Utilities.
    FlutterError.onError = crashHandler?.handleFlutterError ?? this.crashHandler.handleFlutterError;
    PlatformDispatcher.instance.onError = crashHandler?.handleAsyncError ?? this.crashHandler.handleAsyncError;
    locator.registerSingleton<NotedLogger>(logger ?? this.logger);
    locator.registerSingleton<NotedRouter>(router ?? this.router);

    // Repositories.
    locator.registerSingleton<AuthRepository>(authRepository ?? this.authRepository);
    locator.registerSingleton<SettingsRepository>(settingsRepository ?? this.settingsRepository);
    locator.registerSingleton<NotebookRepository>(notebookRepository ?? this.notebookRepository);
  }
}

class LocalEnvironment extends Environment {
  @override
  FirebaseOptions get firebaseOptions => TestFirebaseOptions.currentPlatform;

  @override
  NotedCrashHandler get crashHandler => LocalCrashHandler();

  @override
  NotedLogger get logger => LocalLogger();

  @override
  NotedRouter get router => NotedGoRouter();

  @override
  AuthRepository get authRepository => LocalAuthRepository();

  @override
  SettingsRepository get settingsRepository => LocalSettingsRepository();

  @override
  NotebookRepository get notebookRepository => LocalNotebookRepository();
}

class TestEnvironment extends Environment {
  @override
  FirebaseOptions get firebaseOptions => TestFirebaseOptions.currentPlatform;

  @override
  NotedCrashHandler get crashHandler => FirebaseCrashHandler();

  @override
  NotedLogger get logger => FirebaseLogger();

  @override
  NotedRouter get router => NotedGoRouter();

  @override
  AuthRepository get authRepository => FirebaseAuthRepository();

  @override
  SettingsRepository get settingsRepository => FirebaseSettingsRepository();

  @override
  NotebookRepository get notebookRepository => FirebaseNotebookRepository();
}

class ProdEnvironment extends Environment {
  @override
  AuthRepository get authRepository => throw UnimplementedError();

  @override
  NotedCrashHandler get crashHandler => throw UnimplementedError();

  @override
  FirebaseOptions get firebaseOptions => throw UnimplementedError();

  @override
  NotedLogger get logger => throw UnimplementedError();

  @override
  NotebookRepository get notebookRepository => throw UnimplementedError();

  @override
  NotedRouter get router => throw UnimplementedError();

  @override
  SettingsRepository get settingsRepository => throw UnimplementedError();
}
