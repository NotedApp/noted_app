import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_event.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/environment/environment.dart';
import 'package:noted_app/util/noted_error.dart';
import 'package:noted_models/noted_models.dart';

void main() {
  group('AuthBloc', () {
    NotedUser newUser = NotedUser(id: 'local-11', email: 'test@test.com', name: 'Local 11');
    NotedUser local0 = NotedUser(id: 'local-0', email: 'local-0@noted.com', name: 'shaquille.oatmeal');
    NotedUser google = NotedUser(id: 'local-google', email: 'local-google@noted.com', name: 'googly_woogly');

    LocalAuthRepository getRepository() {
      return locator<AuthRepository>() as LocalAuthRepository;
    }

    setUpAll(() {
      LocalEnvironment().configure();
    });

    setUp(() {
      getRepository().reset();
      getRepository().setMsDelay(1);
    });

    blocTest(
      'signs up',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignUpWithEmailEvent('test@test.com', 'local')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        AuthState.authenticating(status: AuthStatus.signing_up),
        AuthState.authenticated(user: newUser),
      ],
    );

    blocTest(
      'signs up and handles error',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignUpWithEmailEvent('12', 'local')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        AuthState.authenticating(status: AuthStatus.signing_up),
        AuthState.unauthenticated(),
      ],
      errors: () => [isA<NotedError>()],
    );

    blocTest(
      'signs in with email',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignInWithEmailEvent('local-0@noted.com', 'local')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        AuthState.authenticating(status: AuthStatus.signing_in),
        AuthState.authenticated(user: local0),
      ],
    );

    blocTest(
      'signs in with email and handles error',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignInWithEmailEvent('test', 'test')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        AuthState.authenticating(status: AuthStatus.signing_in),
        AuthState.unauthenticated(),
      ],
      errors: () => [isA<NotedError>()],
    );

    blocTest(
      'signs in with google',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignInWithGoogleEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        AuthState.authenticating(status: AuthStatus.signing_in),
        AuthState.authenticated(user: google),
      ],
    );

    blocTest(
      'signs in with google and handles error',
      build: AuthBloc.new,
      act: (bloc) {
        getRepository().setShouldThrow(true);
        bloc.add(AuthSignInWithGoogleEvent());
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        AuthState.authenticating(status: AuthStatus.signing_in),
        AuthState.unauthenticated(),
      ],
      errors: () => [isA<NotedError>()],
    );

    blocTest(
      'signs in with apple',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignInWithAppleEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        AuthState.authenticating(status: AuthStatus.signing_in),
        AuthState.unauthenticated(),
      ],
      errors: () => [isA<UnimplementedError>()],
    );

    blocTest(
      'signs in with facebook',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignInWithFacebookEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        AuthState.authenticating(status: AuthStatus.signing_in),
        AuthState.unauthenticated(),
      ],
      errors: () => [isA<UnimplementedError>()],
    );

    blocTest(
      'signs in with github',
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignInWithGithubEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        AuthState.authenticating(status: AuthStatus.signing_in),
        AuthState.unauthenticated(),
      ],
      errors: () => [isA<UnimplementedError>()],
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
        AuthState.authenticating(status: AuthStatus.signing_out),
        AuthState.unauthenticated(),
      ],
    );

    blocTest(
      'signs out and handles error',
      setUp: () async {
        await getRepository().signInWithGoogle();
        getRepository().setShouldThrow(true);
      },
      build: AuthBloc.new,
      act: (bloc) => bloc.add(AuthSignOutEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        AuthState.authenticating(status: AuthStatus.signing_out),
        AuthState.authenticated(user: google),
      ],
      errors: () => [isA<NotedError>()],
    );
  });
}
