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
  repository_auth_createUser_failed,
  repository_auth_createUser_invalidEmail,
  repository_auth_createUser_disabled,
  repository_auth_createUser_existingAccount,
  repository_auth_createUser_weakPassword,

  repository_auth_emailSignIn_failed,
  repository_auth_emailSignIn_disabled,
  repository_auth_emailSignIn_invalidEmail,
  repository_auth_emailSignIn_invalidPassword,

  repository_auth_googleSignIn_failed,
  repository_auth_googleSignIn_existingAccount,
  repository_auth_googleSignIn_disabled,
  repository_auth_googleSignIn_invalidEmail,
  repository_auth_googleSignIn_invalidPassword,

  repository_auth_logOut_failed,

  // State management error codes.
  state_theme_customFetchFailed,
}
