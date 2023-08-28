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
  auth_createUser_failed,
  auth_createUser_invalidEmail,
  auth_createUser_disabled,
  auth_createUser_existingAccount,
  auth_createUser_weakPassword,
  auth_emailSignIn_failed,
  auth_emailSignIn_disabled,
  auth_emailSignIn_invalidEmail,
  auth_emailSignIn_invalidPassword,
  auth_googleSignIn_failed,
  auth_googleSignIn_existingAccount,
  auth_googleSignIn_disabled,
  auth_signOut_failed,
  auth_passwordReset_failed,
  auth_passwordReset_invalidEmail,
  auth_deleteAccount_failed,
  auth_deleteAccount_reauthenticate,
  auth_changePassword_failed,
  auth_changePassword_reauthenticate,
  auth_changePassword_weakPassword,

  settings_fetch_failed,
  settings_updateStyle_failed,

  notebook_subscribe_failed,
  notebook_parse_failed,
  notebook_add_failed,
  notebook_update_failed,
  notebook_delete_failed,
}
