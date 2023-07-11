import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_models/noted_models.dart';

/// An [AuthRepository] that uses mock data as its source of truth.
class LocalAuthRepository extends AuthRepository {
  @override
  // TODO: implement currentUser
  NotedUser get currentUser => throw UnimplementedError();

  @override
  // TODO: implement user
  Stream<NotedUser> get user => throw UnimplementedError();

  @override
  Future<void> createUserWithEmailAndPassword({String email = '', String password = ''}) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmailAndPassword({String email = '', String password = ''}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithGithub() {
    // TODO: implement signInWithGithub
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
