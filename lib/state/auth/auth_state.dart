import 'package:equatable/equatable.dart';
import 'package:noted_app/util/noted_exception.dart';
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
  final NotedUser user;
  final NotedException? error;

  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.user = const NotedUser.empty(),
    this.error = null,
  });

  const AuthState.unauthenticated({NotedException? error}) : this(error: error);

  const AuthState.authenticated({
    required NotedUser user,
    NotedException? error,
  }) : this(status: AuthStatus.authenticated, user: user, error: error);

  const AuthState.authenticating({required AuthStatus status}) : this(status: status);

  @override
  List<Object?> get props => [status, user, error];
}
