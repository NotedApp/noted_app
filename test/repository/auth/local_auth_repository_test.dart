import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

void main() {
  const UserModel expected = UserModel(id: 'local-11', name: 'Local 11', email: 'email');
  const UserModel local = UserModel(id: 'local-0', email: 'local-0@noted.com', name: 'shaquille.oatmeal');

  late LocalAuthRepository repository;

  setUp(() {
    repository = LocalAuthRepository();
    repository.msDelay = 1;
  });

  group('LocalAuthRepository', () {
    test('creates a user and signs in/out with email and password', () async {
      expectLater(
        repository.userStream,
        emitsInOrder(
          [
            expected,
            const UserModel.empty(),
            expected,
            const UserModel.empty(),
            local,
          ],
        ),
      );

      // Test create with invalid email.
      await expectLater(
        () => repository.createUserWithEmailAndPassword(email: '12', password: 'password'),
        throwsA(NotedError(ErrorCode.auth_createUser_invalidEmail)),
      );
      expect(repository.currentUser, const UserModel.empty());

      // Test create with invalid password.
      await expectLater(
        () => repository.createUserWithEmailAndPassword(email: 'email', password: '12'),
        throwsA(NotedError(ErrorCode.auth_createUser_weakPassword)),
      );
      expect(repository.currentUser, const UserModel.empty());

      // Test create with valid credentials.
      await repository.createUserWithEmailAndPassword(email: 'email', password: 'password');
      expect(repository.currentUser, expected);

      // Test sign out.
      await repository.signOut();
      expect(repository.currentUser, const UserModel.empty());

      // Test sign in with correct email and password.
      await repository.signInWithEmailAndPassword(email: 'email', password: 'password');
      expect(repository.currentUser, expected);

      // Test sign out.
      await repository.signOut();
      expect(repository.currentUser, const UserModel.empty());

      // Test sign in with invalid email.
      await expectLater(
        () => repository.signInWithEmailAndPassword(email: 'test', password: 'password'),
        throwsA(NotedError(ErrorCode.auth_emailSignIn_invalidEmail)),
      );
      expect(repository.currentUser, const UserModel.empty());

      // Test sign in with invalid password.
      await expectLater(
        () => repository.signInWithEmailAndPassword(email: 'email', password: 'test'),
        throwsA(NotedError(ErrorCode.auth_emailSignIn_invalidPassword)),
      );
      expect(repository.currentUser, const UserModel.empty());

      // Test sign in with existing local acount.
      await repository.signInWithEmailAndPassword(email: 'local-0@noted.com', password: 'local');
      expect(repository.currentUser, local);

      // Test dispose.
      await repository.onDispose();
    });

    test('signs in with google', () async {
      UserModel expected = const UserModel(id: 'local-google', name: 'googly_woogly', email: 'local-google@noted.com');

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
      expect(repository.currentUser, const UserModel.empty());
    });

    test('throws for a password reset email', () async {
      repository.shouldThrow = true;

      await expectLater(
        () => repository.sendPasswordResetEmail(email: 'test'),
        throwsA(NotedError(ErrorCode.auth_passwordReset_failed)),
      );
      expect(repository.currentUser, const UserModel.empty());
    });

    test('changes the account password', () async {
      await repository.signInWithEmailAndPassword(email: 'local-0@noted.com', password: 'local');
      expect(repository.currentUser, local);

      await repository.changePassword(password: 'password');

      await repository.signOut();
      expect(repository.currentUser, const UserModel.empty());

      await repository.signInWithEmailAndPassword(email: 'local-0@noted.com', password: 'password');
      expect(repository.currentUser, local);
    });

    test('throws for a password change', () async {
      await repository.signInWithEmailAndPassword(email: 'local-0@noted.com', password: 'local');
      expect(repository.currentUser, local);

      repository.shouldThrow = true;

      await expectLater(
        () => repository.changePassword(password: 'password'),
        throwsA(NotedError(ErrorCode.auth_changePassword_failed)),
      );
    });

    test('deletes the current account', () async {
      await repository.signInWithEmailAndPassword(email: 'local-0@noted.com', password: 'local');
      expect(repository.currentUser, local);

      await repository.deleteAccount();
      expect(repository.currentUser, const UserModel.empty());

      await expectLater(
        () => repository.signInWithEmailAndPassword(email: 'local-0@noted.com', password: 'local'),
        throwsA(NotedError(ErrorCode.auth_emailSignIn_invalidEmail)),
      );
    });

    test('throws for an account delete', () async {
      await repository.signInWithEmailAndPassword(email: 'local-0@noted.com', password: 'local');
      expect(repository.currentUser, local);

      repository.shouldThrow = true;

      await expectLater(
        () => repository.deleteAccount(),
        throwsA(NotedError(ErrorCode.auth_deleteAccount_failed)),
      );
    });

    test('throws and resets when requested', () async {
      UserModel expected = const UserModel(id: 'local-google', name: 'googly_woogly', email: 'local-google@noted.com');

      repository.shouldThrow = true;

      await expectLater(
        () => repository.signInWithGoogle(),
        throwsA(NotedError(ErrorCode.auth_googleSignIn_failed)),
      );
      expect(repository.currentUser, const UserModel.empty());

      repository.reset();

      await repository.signInWithGoogle();
      expect(repository.currentUser, expected);
    });
  });
}
