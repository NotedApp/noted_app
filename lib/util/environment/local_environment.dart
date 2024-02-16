// coverage:ignore-file
import 'package:firebase_core/firebase_core.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/repository/notes/local_notes_repository.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/repository/ogp/local_ogp_repository.dart';
import 'package:noted_app/repository/ogp/ogp_repository.dart';
import 'package:noted_app/repository/settings/local_settings_repository.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/ui/router/noted_go_router.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/util/environment/environment.dart';
import 'package:noted_app/util/errors/local_crash_handler.dart';
import 'package:noted_app/util/errors/noted_crash_handler.dart';
import 'package:noted_app/util/logging/local_logger.dart';
import 'package:noted_app/util/logging/noted_logger.dart';

class LocalEnvironment extends Environment {
  @override
  FirebaseOptions? get firebaseOptions => null;

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
  NotesRepository get notebookRepository => LocalNotesRepository();

  @override
  OgpRepository get ogpRepository => LocalOgpRepository();
}
