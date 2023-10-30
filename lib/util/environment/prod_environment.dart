part of 'environment.dart';

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
}
