part of 'environment.dart';

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
}
