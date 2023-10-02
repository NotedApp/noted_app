import 'package:equatable/equatable.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

enum AuthStatus {
  unauthenticated,
  signingOut,
  signingUp,
  signingIn,
  sendingPasswordReset,
  changingPassword,
  deletingAccount,
  authenticated,
}

final class AuthState extends Equatable {
  final AuthStatus status;
  final UserModel user;
  final NotedError? error;

  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.user = const UserModel.empty(),
    this.error = null,
  });

  const AuthState.unauthenticated({NotedError? error}) : this(error: error);

  const AuthState.authenticated({
    required UserModel user,
    NotedError? error,
  }) : this(status: AuthStatus.authenticated, user: user, error: error);

  const AuthState.authenticating({required AuthStatus status}) : this(status: status);

  @override
  List<Object?> get props => [status, user, error];
}
