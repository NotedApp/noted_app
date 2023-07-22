import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

// TODO: Test this file.
// coverage:ignore-file
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
  NotedUser get currentUser => _firebaseAuth.currentUser?._toNoted ?? NotedUser.empty();

  @override
  Stream<NotedUser> get userStream {
    return _firebaseAuth.authStateChanges().map((firebaseUser) => firebaseUser?._toNoted ?? NotedUser.empty());
  }

  @override
  Future<void> createUserWithEmailAndPassword({String email = '', String password = ''}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw NotedException(_getCreateUserErrorCode(e.code));
    } catch (_) {
      throw NotedException(ErrorCode.auth_createUser_failed);
    }
  }

  @override
  Future<void> signInWithEmailAndPassword({String email = '', String password = ''}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw NotedException(_getEmailSignInErrorCode(e.code));
    } catch (_) {
      throw NotedException(ErrorCode.auth_createUser_failed);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      late final AuthCredential credential;

      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        UserCredential userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
        credential = userCredential.credential!;
      } else {
        GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();
        googleUser ??= await _googleSignIn.signIn();
        GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
        credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw NotedException(_getGoogleSignInErrorCode(e.code));
    } catch (_) {
      throw NotedException(ErrorCode.auth_googleSignIn_failed);
    }
  }

  @override
  Future<void> signInWithApple() async {
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithFacebook() async {
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithGithub() async {
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
      throw NotedException(ErrorCode.auth_signOut_failed);
    }
  }

  @override
  Future<void> sendPasswordResetEmail({String email = ''}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw NotedException(_getPasswordResetErrorCode(e.code));
    } catch (_) {
      throw NotedException(ErrorCode.auth_passwordReset_failed);
    }
  }

  ErrorCode _getCreateUserErrorCode(String code) {
    return switch (code) {
      'invalid-email' => ErrorCode.auth_createUser_invalidEmail,
      'user-disabled' => ErrorCode.auth_createUser_disabled,
      'operation-not-allowed' => ErrorCode.auth_createUser_disabled,
      'email-already-in-use' => ErrorCode.auth_createUser_existingAccount,
      'weak-password' => ErrorCode.auth_createUser_weakPassword,
      _ => ErrorCode.auth_createUser_failed,
    };
  }

  ErrorCode _getEmailSignInErrorCode(String code) {
    return switch (code) {
      'invalid-email' => ErrorCode.auth_emailSignIn_invalidEmail,
      'user-disabled' => ErrorCode.auth_emailSignIn_disabled,
      'user-not-found' => ErrorCode.auth_emailSignIn_invalidEmail,
      'wrong-password' => ErrorCode.auth_emailSignIn_invalidPassword,
      _ => ErrorCode.auth_emailSignIn_failed,
    };
  }

  ErrorCode _getGoogleSignInErrorCode(String code) {
    return switch (code) {
      'account-exists-with-different-credential' => ErrorCode.auth_googleSignIn_existingAccount,
      'operation-not-allowed' => ErrorCode.auth_googleSignIn_disabled,
      'user-disabled' => ErrorCode.auth_googleSignIn_disabled,
      _ => ErrorCode.auth_googleSignIn_failed,
    };
  }

  ErrorCode _getPasswordResetErrorCode(String code) {
    return switch (code) {
      'invalid-email' => ErrorCode.auth_passwordReset_invalidEmail,
      'user-not-found' => ErrorCode.auth_passwordReset_invalidEmail,
      _ => ErrorCode.auth_passwordReset_failed,
    };
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
