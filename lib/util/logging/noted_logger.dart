/// A class that handles event logging.
abstract class NotedLogger {
  /// Sets the default parameters that should be passed with every logged event.
  void setDefaultParams({required Map<String, Object?> params});

  /// Logs an event with the given [name] and [params].
  void log({required String name, Map<String, Object?> params = const {}});
}
