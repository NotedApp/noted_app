import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/util/noted_error.dart';
import 'package:noted_models/noted_models.dart';

/// An [AuthRepository] that uses Firebase Authentication as its source of truth.
class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

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
  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw NotedError(ErrorCode.repository_auth_logOutFailed);
    }
  }
}

extension on User {
  NotedUser get _toNoted {
    return NotedUser(
      id: uid,
      email: email,
      name: displayName,
    );
  }
}
