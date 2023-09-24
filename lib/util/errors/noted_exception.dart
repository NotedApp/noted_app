import 'package:equatable/equatable.dart';

class NotedError with EquatableMixin implements Exception {
  final ErrorCode code;
  final String message;

  NotedError(this.code, {this.message = ''});

  factory NotedError.fromObject(Object e) {
    if (e is NotedError) {
      return e;
    }

    return NotedError(ErrorCode.common_unknown, message: e.toString());
  }

  @override
  List<Object?> get props => [code, message];
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

  notes_subscribe_failed,
  notes_parse_failed,
  notes_add_failed,
  notes_update_failed,
  notes_delete_failed,
}
