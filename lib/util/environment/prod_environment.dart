import 'package:firebase_core/firebase_core.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/repository/ogp/ogp_repository.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/util/environment/environment.dart';
import 'package:noted_app/util/errors/noted_crash_handler.dart';
import 'package:noted_app/util/logging/noted_logger.dart';

// coverage:ignore-file
class ProdEnvironment extends Environment {
  @override
  FirebaseOptions? get firebaseOptions => throw UnimplementedError();

  @override
  NotedCrashHandler get crashHandler => throw UnimplementedError();

  @override
  NotedLogger get logger => throw UnimplementedError();

  @override
  NotedRouter get router => throw UnimplementedError();

  @override
  AuthRepository get authRepository => throw UnimplementedError();

  @override
  SettingsRepository get settingsRepository => throw UnimplementedError();

  @override
  NotesRepository get notebookRepository => throw UnimplementedError();

  @override
  OgpRepository get ogpRepository => throw UnimplementedError();
}
