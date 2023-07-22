import 'package:equatable/equatable.dart';

class NotedException with EquatableMixin implements Exception {
  final ErrorCode errorCode;
  final String message;

  NotedException(this.errorCode, {this.message = ''});

  factory NotedException.fromObject(Object e) {
    if (e is NotedException) {
      return e;
    }

    return NotedException(ErrorCode.common_unknown, message: e.toString());
  }

  @override
  List<Object?> get props => [errorCode, message];
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

  repository_auth_signOut_failed,

  repository_auth_passwordReset_failed,
  repository_auth_passwordReset_invalidEmail,

  // State management error codes.
  state_theme_customFetchFailed,
}
