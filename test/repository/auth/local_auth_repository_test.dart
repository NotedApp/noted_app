import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

void main() {
  late LocalAuthRepository repository;

  setUp(() {
    repository = LocalAuthRepository();
    repository.setMsDelay(1);
  });

  group('LocalAuthRepository', () {
    test('creates a user and signs in/out with email and password', () async {
      NotedUser expected = NotedUser(id: 'local-11', name: 'Local 11', email: 'email');
      NotedUser local = NotedUser(id: 'local-0', email: 'local-0@noted.com', name: 'shaquille.oatmeal');

      expectLater(
        repository.userStream,
        emitsInOrder(
          [
            expected,
            NotedUser.empty(),
            expected,
            NotedUser.empty(),
            local,
          ],
        ),
      );

      // Test create with invalid email.
      await expectLater(
        () => repository.createUserWithEmailAndPassword(email: '12', password: 'password'),
        throwsA(isA<NotedException>()),
      );
      expect(repository.currentUser, NotedUser.empty());

      // Test create with invalid password.
      await expectLater(
        () => repository.createUserWithEmailAndPassword(email: 'email', password: '12'),
        throwsA(isA<NotedException>()),
      );
      expect(repository.currentUser, NotedUser.empty());

      // Test create with valid credentials.
      await repository.createUserWithEmailAndPassword(email: 'email', password: 'password');
      expect(repository.currentUser, expected);

      // Test sign out.
      await repository.signOut();
      expect(repository.currentUser, NotedUser.empty());

      // Test sign in with correct email and password.
      await repository.signInWithEmailAndPassword(email: 'email', password: 'password');
      expect(repository.currentUser, expected);

      // Test sign out.
      await repository.signOut();
      expect(repository.currentUser, NotedUser.empty());

      // Test sign in with invalid email.
      await expectLater(
        () => repository.signInWithEmailAndPassword(email: 'test', password: 'password'),
        throwsA(isA<NotedException>()),
      );
      expect(repository.currentUser, NotedUser.empty());

      // Test sign in with invalid password.
      await expectLater(
        () => repository.signInWithEmailAndPassword(email: 'email', password: 'test'),
        throwsA(isA<NotedException>()),
      );
      expect(repository.currentUser, NotedUser.empty());

      // Test sign in with existing local acount.
      await repository.signInWithEmailAndPassword(email: 'local-0@noted.com', password: 'local');
      expect(repository.currentUser, local);

      // Test dispose.
      await repository.onDispose();
    });

    test('signs in with google', () async {
      NotedUser expected = NotedUser(id: 'local-google', name: 'googly_woogly', email: 'local-google@noted.com');

      await repository.signInWithGoogle();
      expect(repository.currentUser, expected);
    });

    test('signs in with apple', () async {
      await expectLater(() => repository.signInWithApple(), throwsA(isA<UnimplementedError>()));
    });

    test('signs in with facebook', () async {
      await expectLater(() => repository.signInWithFacebook(), throwsA(isA<UnimplementedError>()));
    });

    test('signs in with github', () async {
      await expectLater(() => repository.signInWithGithub(), throwsA(isA<UnimplementedError>()));
    });

    test('sends a password reset email', () async {
      await repository.sendPasswordResetEmail(email: 'test');
      expect(repository.currentUser, NotedUser.empty());
    });

    test('throws for a password reset email', () async {
      repository.setShouldThrow(true);

      await expectLater(() => repository.sendPasswordResetEmail(email: 'test'), throwsA(isA<NotedException>()));
      expect(repository.currentUser, NotedUser.empty());
    });

    test('throws and resets when requested', () async {
      NotedUser expected = NotedUser(id: 'local-google', name: 'googly_woogly', email: 'local-google@noted.com');

      repository.setShouldThrow(true);

      await expectLater(() => repository.signInWithGoogle(), throwsA(isA<NotedException>()));
      expect(repository.currentUser, NotedUser.empty());

      repository.reset();

      await repository.signInWithGoogle();
      expect(repository.currentUser, expected);
    });
  });
}
