/// A class that handles event logging.
abstract class NotedLogger {
  /// Sets the default parameters that should be passed with every logged event.
  void setDefaultParams({required Map<String, Object?> params});

  /// Logs an event with the given [name], [page], and [params].
  ///
  /// The [page] argument will be added to the [params] map with the key 'page'.
  void logUi({
    required String name,
    required String page,
    Map<String, Object> params = const {},
  }) {
    params['page'] = page;
    log(name: '$page-page-$name', params: params);
  }

  /// Logs an event with the given [name], [bloc], and [params].
  ///
  /// The [bloc] argument will be added to the [params] map with the key 'bloc'.
  void logBloc({
    required String name,
    required String bloc,
    Map<String, Object> params = const {},
  }) {
    params['bloc'] = bloc;
    log(name: '$bloc-bloc-$name', params: params);
  }

  /// Logs an event with the given [name], and [params].
  void log({
    required String name,
    Map<String, Object>? params,
  });
}
