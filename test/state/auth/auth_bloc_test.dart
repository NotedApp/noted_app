import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_event.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

import '../../helpers/environment/unit_test_environment.dart';

void main() {
  group('AuthBloc', () {
    UserModel newUser = const UserModel(id: 'local-11', email: 'test@test.com', name: 'Local 11');
    UserModel local0 = const UserModel(id: 'local-0', email: 'local-0@noted.com', name: 'shaquille.oatmeal');
    UserModel google = const UserModel(id: 'local-google', email: 'local-google@noted.com', name: 'googly_woogly');

    LocalAuthRepository getRepository() {
      return locator<AuthRepository>() as LocalAuthRepository;
    }

    setUpAll(() {
      UnitTestEnvironment().configure();
    });

    setUp(() {
      getRepository().reset();
      getRepository().msDelay = 1;
    });

    blocTest(
      'signs up',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(const AuthSignUpWithEmailEvent('test@test.com', 'local')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.signingUp),
        AuthState.authenticated(user: newUser),
      ],
    );

    blocTest(
      'signs up and handles error',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(const AuthSignUpWithEmailEvent('12', 'local')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.signingUp),
        AuthState.unauthenticated(error: NotedError(ErrorCode.auth_createUser_invalidEmail)),
      ],
    );

    blocTest(
      'signs in with email',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(const AuthSignInWithEmailEvent('local-0@noted.com', 'local')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.signingIn),
        AuthState.authenticated(user: local0),
      ],
    );

    blocTest(
      'signs in with email and handles error',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(const AuthSignInWithEmailEvent('test', 'test')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.signingIn),
        AuthState.unauthenticated(error: NotedError(ErrorCode.auth_emailSignIn_invalidEmail)),
      ],
    );

    blocTest(
      'signs in with google',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignInWithGoogleEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.signingIn),
        AuthState.authenticated(user: google),
      ],
    );

    blocTest(
      'signs in with google and handles error',
      build: AuthBloc.new,
      act: (bloc) {
        getRepository().shouldThrow = true;
        bloc.add(AuthSignInWithGoogleEvent());
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.signingIn),
        AuthState.unauthenticated(error: NotedError(ErrorCode.auth_googleSignIn_failed)),
      ],
    );

    blocTest(
      'signs in with apple',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignInWithAppleEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.signingIn),
        AuthState.unauthenticated(error: NotedError.fromObject(UnimplementedError())),
      ],
    );

    blocTest(
      'signs in with facebook',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignInWithFacebookEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.signingIn),
        AuthState.unauthenticated(error: NotedError.fromObject(UnimplementedError())),
      ],
    );

    blocTest(
      'signs in with github',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignInWithGithubEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.signingIn),
        AuthState.unauthenticated(error: NotedError.fromObject(UnimplementedError())),
      ],
    );

    blocTest(
      'signs out',
      setUp: () async {
        await getRepository().signInWithGoogle();
      },
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignOutEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.signingOut),
        const AuthState.unauthenticated(),
      ],
    );

    blocTest(
      'signs out and handles error',
      setUp: () async {
        await getRepository().signInWithGoogle();
        getRepository().shouldThrow = true;
      },
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignOutEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.signingOut),
        AuthState.authenticated(user: google, error: NotedError(ErrorCode.auth_signOut_failed)),
      ],
    );

    blocTest(
      'sends password reset email',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(const AuthSendPasswordResetEvent('test')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.sendingPasswordReset),
        const AuthState.unauthenticated(),
      ],
    );

    blocTest(
      'sends password reset email and handles error',
      setUp: () async {
        getRepository().shouldThrow = true;
      },
      build: AuthBloc.new,
      act: (bloc) => bloc.add(const AuthSendPasswordResetEvent('test')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.sendingPasswordReset),
        AuthState.unauthenticated(error: NotedError(ErrorCode.auth_passwordReset_failed)),
      ],
    );

    blocTest(
      'changes account password',
      setUp: () async {
        await getRepository().signInWithGoogle();
      },
      build: AuthBloc.new,
      act: (bloc) => bloc.add(const AuthChangePasswordEvent('test')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.changingPassword),
        AuthState.authenticated(user: google),
      ],
    );

    blocTest(
      'changes account password and handles error',
      setUp: () async {
        await getRepository().signInWithGoogle();
        getRepository().shouldThrow = true;
      },
      build: AuthBloc.new,
      act: (bloc) => bloc.add(const AuthChangePasswordEvent('test')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.changingPassword),
        AuthState.authenticated(user: google, error: NotedError(ErrorCode.auth_changePassword_failed)),
      ],
    );

    blocTest(
      'deletes current account',
      setUp: () async {
        await getRepository().signInWithGoogle();
      },
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthDeleteAccountEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.deletingAccount),
        const AuthState.unauthenticated(),
      ],
    );

    blocTest(
      'deletes current account and handles error',
      setUp: () async {
        await getRepository().signInWithGoogle();
        getRepository().shouldThrow = true;
      },
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthDeleteAccountEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const AuthState.authenticating(status: AuthStatus.deletingAccount),
        AuthState.authenticated(user: google, error: NotedError(ErrorCode.auth_deleteAccount_failed)),
      ],
    );
  });
}
