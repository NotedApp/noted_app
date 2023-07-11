import 'package:equatable/equatable.dart';

class NotedError extends Error with EquatableMixin {
  final ErrorCode errorCode;

  NotedError(this.errorCode);

  @override
  List<Object?> get props => [errorCode];
}

enum ErrorCode {
  // Common error codes.
  common_unknown,

  // Repository error codes.
  repository_auth_logOutFailed,

  // State management error codes.
  state_theme_customFetchFailed,
}
