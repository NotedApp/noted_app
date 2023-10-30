part of 'environment.dart';

// coverage:ignore-file
class TestEnvironment extends Environment {
  @override
  FirebaseOptions? get firebaseOptions => TestFirebaseOptions.currentPlatform;

  @override
  NotedCrashHandler get crashHandler => LocalCrashHandler();

  @override
  NotedLogger get logger => LocalLogger();

  @override
  NotedRouter get router => NotedGoRouter();

  @override
  AuthRepository get authRepository => FirebaseAuthRepository();

  @override
  SettingsRepository get settingsRepository => FirebaseSettingsRepository();

  @override
  NotesRepository get notebookRepository => FirebaseNotesRepository();
}
