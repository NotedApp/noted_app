import 'package:equatable/equatable.dart';
import 'package:noted_models/noted_models.dart';

enum AuthStatus {
  unauthenticated,
  signing_out,
  signing_up,
  signing_in,
  signing_in_silently,
  authenticated,
}

final class AuthState extends Equatable {
  final AuthStatus status;
  final NotedUser user;

  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.user = const NotedUser.empty(),
  });

  const AuthState.unauthenticated() : this();

  const AuthState.authenticated({required NotedUser user}) : this(status: AuthStatus.authenticated, user: user);

  const AuthState.authenticating({required AuthStatus status}) : this(status: status);

  @override
  List<Object?> get props => [status, user];
}
