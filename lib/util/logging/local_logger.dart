import 'package:noted_app/util/logging/noted_logger.dart';
import 'dart:developer' as developer;

// coverage:ignore-file
class LocalLogger extends NotedLogger {
  Map<String, dynamic> _defaultParams = {};

  @override
  void setDefaultParams({required Map<String, Object?> params}) => _defaultParams = params;

  @override
  void log({required String name, Map<String, Object?> params = const {}}) {
    developer.log({..._defaultParams, ...params}.toString(), name: name);
  }
}
