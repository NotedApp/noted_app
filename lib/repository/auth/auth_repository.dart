import 'package:noted_models/noted_models.dart';

/// A repository that handles user authentication.
abstract class AuthRepository {
  /// Returns the current user.
  ///
  /// Returns [NotedUser.empty] if the user is not authenticated.
  NotedUser get currentUser;

  /// A [Stream] that emits a new user whenever the user's authentication state changes.
  ///
  /// Emits [NotedUser.empty] if the user is not authenticated.
  Stream<NotedUser> get userStream;

  /// Creates a new user with the provided [email] and [password].
  Future<void> createUserWithEmailAndPassword({String email, String password});

  /// Signs in a user with the provided [email] and [password].
  Future<void> signInWithEmailAndPassword({String email, String password});

  /// Initiates the Google sign in flow.
  Future<void> signInWithGoogle();

  /// Initiates the Apple sign in flow.
  Future<void> signInWithApple();

  /// Initiates the Facebook sign in flow.
  Future<void> signInWithFacebook();

  /// Initiates the Github sign in flow.
  Future<void> signInWithGithub();

  /// Signs the current user out.
  Future<void> signOut();
}
