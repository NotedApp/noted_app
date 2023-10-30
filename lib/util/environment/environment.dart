import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/firebase_auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/repository/notes/firebase_notebook_repository.dart';
import 'package:noted_app/repository/notes/local_notebook_repository.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/repository/settings/firebase_settings_repository.dart';
import 'package:noted_app/repository/settings/local_settings_repository.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/environment/test_firebase_options.dart';
import 'package:noted_app/util/errors/local_crash_handler.dart';
import 'package:noted_app/util/errors/noted_crash_handler.dart';
import 'package:noted_app/util/logging/local_logger.dart';
import 'package:noted_app/util/logging/noted_logger.dart';
import 'package:noted_app/ui/router/noted_go_router.dart';
import 'package:noted_app/ui/router/noted_router.dart';

part 'local_environment.dart';
part 'test_environment.dart';
part 'prod_environment.dart';

// coverage:ignore-file
abstract class Environment {
  FirebaseOptions? get firebaseOptions;
  NotedCrashHandler get crashHandler;
  NotedLogger get logger;
  NotedRouter get router;
  AuthRepository get authRepository;
  SettingsRepository get settingsRepository;
  NotesRepository get notebookRepository;

  Future<void> configure({
    FirebaseOptions? firebaseOptions,
    NotedCrashHandler? crashHandler,
    NotedLogger? logger,
    NotedRouter? router,
    AuthRepository? authRepository,
    SettingsRepository? settingsRepository,
    NotesRepository? notebookRepository,
  }) async {
    FirebaseOptions? options = firebaseOptions ?? this.firebaseOptions;

    await WidgetsFlutterBinding.ensureInitialized();

    if (options != null) {
      await Firebase.initializeApp(options: firebaseOptions);
    }

    // Utilities.
    FlutterError.onError = crashHandler?.handleFlutterError ?? this.crashHandler.handleFlutterError;
    PlatformDispatcher.instance.onError = crashHandler?.handleAsyncError ?? this.crashHandler.handleAsyncError;
    locator.registerSingleton<NotedLogger>(logger ?? this.logger);
    locator.registerSingleton<NotedRouter>(router ?? this.router);

    // Repositories.
    locator.registerSingleton<AuthRepository>(authRepository ?? this.authRepository);
    locator.registerSingleton<SettingsRepository>(settingsRepository ?? this.settingsRepository);
    locator.registerSingleton<NotesRepository>(notebookRepository ?? this.notebookRepository);
  }
}
