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
import 'package:noted_app/util/logging/firebase_logger.dart';
import 'package:noted_app/util/logging/local_logger.dart';
import 'package:noted_app/util/logging/noted_logger.dart';
import 'package:noted_app/ui/router/noted_go_router.dart';
import 'package:noted_app/ui/router/noted_router.dart';

// coverage:ignore-file
abstract class Environment {
  Future<void> configure({
    NotedLogger? logger,
    NotedRouter? router,
    AuthRepository? authRepository,
    SettingsRepository? settingsRepository,
    NotebookRepository? notebookRepository,
  });
}

class LocalEnvironment extends Environment {
  @override
  Future<void> configure({
    NotedLogger? logger,
    NotedRouter? router,
    AuthRepository? authRepository,
    SettingsRepository? settingsRepository,
    NotebookRepository? notebookRepository,
  }) async {
    // Utilities.
    locator.registerSingleton<NotedLogger>(logger ?? LocalLogger());
    locator.registerSingleton<NotedRouter>(router ?? NotedGoRouter());

    // Repositories.
    locator.registerSingleton<AuthRepository>(authRepository ?? LocalAuthRepository());
    locator.registerSingleton<SettingsRepository>(settingsRepository ?? LocalSettingsRepository());
    locator.registerSingleton<NotebookRepository>(notebookRepository ?? LocalNotebookRepository());
  }
}

class TestEnvironment extends Environment {
  @override
  Future<void> configure({
    NotedLogger? logger,
    NotedRouter? router,
    AuthRepository? authRepository,
    SettingsRepository? settingsRepository,
    NotebookRepository? notebookRepository,
  }) async {
    await WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: TestFirebaseOptions.currentPlatform);

    // Utilities.
    locator.registerSingleton<NotedLogger>(logger ?? FirebaseLogger());
    locator.registerSingleton<NotedRouter>(router ?? NotedGoRouter());

    // Repositories.
    locator.registerSingleton<AuthRepository>(authRepository ?? FirebaseAuthRepository());
    locator.registerSingleton<SettingsRepository>(settingsRepository ?? FirebaseSettingsRepository());
    locator.registerSingleton<NotebookRepository>(notebookRepository ?? FirebaseNotebookRepository());
  }
}

class ProdEnvironment extends Environment {
  @override
  Future<void> configure({
    NotedLogger? logger,
    NotedRouter? router,
    AuthRepository? authRepository,
    SettingsRepository? settingsRepository,
    NotebookRepository? notebookRepository,
  }) async {
    throw UnimplementedError();
  }
}
