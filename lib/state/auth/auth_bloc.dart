import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/state/auth/auth_event.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

class AuthBloc extends NotedBloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  late final StreamSubscription<UserModel> _userSubscription;

  AuthBloc({AuthRepository? authRepository})
      : _repository = authRepository ?? locator<AuthRepository>(),
        super(
          (authRepository?.currentUser ?? locator<AuthRepository>().currentUser).isNotEmpty
              ? AuthState.authenticated(user: authRepository?.currentUser ?? locator<AuthRepository>().currentUser)
              : AuthState.unauthenticated(),
          'auth',
        ) {
    on<AuthSignUpWithEmailEvent>(_onSignUpWithEmail);
    on<AuthSignInWithEmailEvent>(_onSignIn);
    on<AuthSignInWithGoogleEvent>(_onSignIn);
    on<AuthSignInWithAppleEvent>(_onSignIn);
    on<AuthSignInWithFacebookEvent>(_onSignIn);
    on<AuthSignInWithGithubEvent>(_onSignIn);
    on<AuthSignOutEvent>(_onSignOut);
    on<AuthSendPasswordResetEvent>(_onResetPassword);
    on<AuthChangePasswordEvent>(_onChangePassword);
    on<AuthDeleteAccountEvent>(_onDeleteAccount);
    on<AuthUserUpdatedEvent>(_onUserChanged);

    _userSubscription = _repository.userStream.listen((user) => add(AuthUserUpdatedEvent(user)));
  }

  void _onSignUpWithEmail(AuthSignUpWithEmailEvent event, Emitter<AuthState> emit) async {
    if (state.status != AuthStatus.unauthenticated) {
      return;
    }

    try {
      emit(AuthState.authenticating(status: AuthStatus.signingUp));
      await _repository.createUserWithEmailAndPassword(email: event.email, password: event.password);
    } catch (e) {
      emit(AuthState.unauthenticated(error: NotedError.fromObject(e)));
    }
  }

  void _onSignIn(AuthEvent event, Emitter<AuthState> emit) async {
    if (state.status != AuthStatus.unauthenticated) {
      return;
    }

    try {
      emit(AuthState.authenticating(status: AuthStatus.signingIn));

      switch (event) {
        case AuthSignInWithEmailEvent _:
          await _repository.signInWithEmailAndPassword(email: event.email, password: event.password);
        case AuthSignInWithGoogleEvent _:
          await _repository.signInWithGoogle();
        case AuthSignInWithAppleEvent _:
          await _repository.signInWithApple();
        case AuthSignInWithFacebookEvent _:
          await _repository.signInWithFacebook();
        case AuthSignInWithGithubEvent _:
          await _repository.signInWithGithub();
        case _:
          throw StateError('Auth bloc handled a non-sign-in event as a sign-in event.'); // coverage:ignore-line
      }
    } catch (e) {
      emit(AuthState.unauthenticated(error: NotedError.fromObject(e)));
    }
  }

  void _onSignOut(AuthSignOutEvent event, Emitter<AuthState> emit) async {
    if (state.status != AuthStatus.authenticated) {
      return;
    }

    try {
      emit(AuthState.authenticating(status: AuthStatus.signingOut));
      await _repository.signOut();
    } catch (e) {
      UserModel current = _repository.currentUser;
      AuthStatus status = current.isEmpty ? AuthStatus.unauthenticated : AuthStatus.authenticated;
      NotedError error = NotedError.fromObject(e);
      emit(AuthState(user: current, status: status, error: error));
    }
  }

  void _onResetPassword(AuthSendPasswordResetEvent event, Emitter<AuthState> emit) async {
    if (state.status != AuthStatus.unauthenticated) {
      return;
    }

    try {
      emit(AuthState.authenticating(status: AuthStatus.sendingPasswordReset));
      await _repository.sendPasswordResetEmail(email: event.email);
      emit(AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.unauthenticated(error: NotedError.fromObject(e)));
    }
  }

  void _onChangePassword(AuthChangePasswordEvent event, Emitter<AuthState> emit) async {
    if (state.status != AuthStatus.authenticated) {
      return;
    }

    try {
      emit(AuthState.authenticating(status: AuthStatus.changingPassword));
      await _repository.changePassword(password: event.password);
      emit(AuthState.authenticated(user: _repository.currentUser));
    } catch (e) {
      emit(AuthState.authenticated(user: _repository.currentUser, error: NotedError.fromObject(e)));
    }
  }

  void _onDeleteAccount(AuthDeleteAccountEvent event, Emitter<AuthState> emit) async {
    if (state.status != AuthStatus.authenticated) {
      return;
    }

    try {
      emit(AuthState.authenticating(status: AuthStatus.deletingAccount));
      await _repository.deleteAccount();
    } catch (e) {
      UserModel current = _repository.currentUser;
      AuthStatus status = current.isEmpty ? AuthStatus.unauthenticated : AuthStatus.authenticated;
      NotedError error = NotedError.fromObject(e);
      emit(AuthState(user: current, status: status, error: error));
    }
  }

  void _onUserChanged(AuthUserUpdatedEvent event, Emitter<AuthState> emit) {
    emit(event.user.isNotEmpty ? AuthState.authenticated(user: event.user) : AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
