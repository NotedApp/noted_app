import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_models/noted_models.dart';

sealed class AuthEvent extends NotedEvent implements TrackableEvent {
  const AuthEvent();
}

class AuthSignUpWithEmailEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignUpWithEmailEvent(this.email, this.password);
}

class AuthSignInWithEmailEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInWithEmailEvent(this.email, this.password);
}

class AuthSignInWithGoogleEvent extends AuthEvent {}

class AuthSignInWithAppleEvent extends AuthEvent {}

class AuthSignInWithFacebookEvent extends AuthEvent {}

class AuthSignInWithGithubEvent extends AuthEvent {}

class AuthSignOutEvent extends AuthEvent {}

class AuthSendPasswordResetEvent extends AuthEvent {
  final String email;

  const AuthSendPasswordResetEvent(this.email);
}

class AuthChangePasswordEvent extends AuthEvent {
  final String password;

  const AuthChangePasswordEvent(this.password);
}

class AuthDeleteAccountEvent extends AuthEvent {}

class AuthUserUpdatedEvent extends AuthEvent {
  final UserModel user;

  const AuthUserUpdatedEvent(this.user);
}
