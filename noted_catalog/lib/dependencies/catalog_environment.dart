import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/repository/notes/local_notebook_repository.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/repository/settings/local_settings_repository.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/util/environment/environment.dart';
import 'package:noted_app/util/errors/local_crash_handler.dart';
import 'package:noted_app/util/errors/noted_crash_handler.dart';
import 'package:noted_app/util/logging/local_logger.dart';
import 'package:noted_app/util/logging/noted_logger.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_catalog/dependencies/catalog_router.dart';
import 'package:noted_models/noted_models.dart';

const UserModel _catalogUser = UserModel(
  id: 'catalog',
  name: 'catalog',
  email: 'catalog@catalog.com',
);

class CatalogEnvironment extends Environment {
  @override
  FirebaseOptions? get firebaseOptions => null;

  @override
  NotedCrashHandler get crashHandler => LocalCrashHandler();

  @override
  NotedLogger get logger => LocalLogger();

  @override
  NotedRouter get router => CatalogRouter();

  @override
  AuthRepository get authRepository => LocalAuthRepository(user: _catalogUser);

  @override
  SettingsRepository get settingsRepository => LocalSettingsRepository();

  @override
  NotesRepository get notebookRepository => LocalNotesRepository();
}
