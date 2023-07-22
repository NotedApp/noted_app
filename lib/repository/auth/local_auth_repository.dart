import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/util/noted_error.dart';
import 'package:noted_models/noted_models.dart';

/// An [AuthRepository] that uses mock data as its source of truth.
class LocalAuthRepository extends AuthRepository implements Disposable {
  final StreamController<NotedUser> _userStreamController = StreamController.broadcast();
  NotedUser _currentUser = NotedUser.empty();
  bool _shouldThrow = false;
  int _msDelay = 2000;

  @override
  NotedUser get currentUser => _currentUser;

  @override
  Stream<NotedUser> get userStream => _userStreamController.stream;

  @override
  Future<void> createUserWithEmailAndPassword({String email = '', String password = ''}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (email.length < 3) {
      throw NotedException(ErrorCode.repository_auth_createUser_invalidEmail);
    }

    if (password.length < 3) {
      throw NotedException(ErrorCode.repository_auth_createUser_weakPassword);
    }

    NotedUser user = NotedUser(
      id: 'local-${_localUsers.length}',
      email: email,
      name: 'Local ${_localUsers.length}',
    );

    _localUsers.add(user);
    _localPasswords.add(password);

    await _updateUser(user, ErrorCode.repository_auth_createUser_failed, delay: false);
  }

  @override
  Future<void> signInWithEmailAndPassword({String email = '', String password = ''}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    NotedUser user = _localUsers.firstWhere((user) => user.email == email, orElse: NotedUser.empty);

    if (user.isEmpty) {
      throw NotedException(ErrorCode.repository_auth_emailSignIn_invalidEmail);
    }

    if (!_localPasswords.contains(password)) {
      throw NotedException(ErrorCode.repository_auth_emailSignIn_invalidPassword);
    }

    await _updateUser(user, ErrorCode.repository_auth_emailSignIn_failed);
  }

  @override
  Future<void> signInWithGoogle() async {
    NotedUser googleUser = _localUsers.firstWhere((user) => user.id == 'local-google');
    await _updateUser(googleUser, ErrorCode.repository_auth_googleSignIn_failed);
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
    await _updateUser(NotedUser.empty(), ErrorCode.repository_auth_signOut_failed);
  }

  @override
  Future<void> sendPasswordResetEmail({String email = ''}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw NotedException(ErrorCode.repository_auth_passwordReset_failed);
    }
  }

  @override
  FutureOr onDispose() async {
    await _userStreamController.close();
  }

  Future<void> _updateUser(NotedUser user, ErrorCode error, {bool delay = true}) async {
    if (delay) {
      await Future.delayed(Duration(milliseconds: _msDelay));
    }

    if (_shouldThrow) {
      throw NotedException(error);
    }

    _currentUser = user;
    _userStreamController.add(user);
  }

  void setShouldThrow(bool shouldThrow) => _shouldThrow = shouldThrow;
  void setMsDelay(int msDelay) => _msDelay = msDelay;
  void reset() {
    _shouldThrow = false;
    _msDelay = 2000;
    _currentUser = NotedUser.empty();
  }
}

/// A list of [NotedUser]s who can be logged in in a local environment.
List<NotedUser> _localUsers = [
  NotedUser(id: 'local-0', email: 'local-0@noted.com', name: 'shaquille.oatmeal'),
  NotedUser(id: 'local-1', email: 'local-1@noted.com', name: 'averagestudent'),
  NotedUser(id: 'local-2', email: 'local-2@noted.com', name: 'me_for_president'),
  NotedUser(id: 'local-3', email: 'local-3@noted.com', name: 'chickenriceandbeans'),
  NotedUser(id: 'local-4', email: 'local-4@noted.com', name: 'fluffycookie'),
  NotedUser(id: 'local-5', email: 'local-5@noted.com', name: 'averagestudent'),
  NotedUser(id: 'local-6', email: 'local-6@noted.com', name: 'LactoseTheIntolerant'),
  NotedUser(id: 'local-7', email: 'local-7@noted.com', name: 'kim_chi'),
  NotedUser(id: 'local-8', email: 'local-8@noted.com', name: 'just-a-harmless-potato'),
  NotedUser(id: 'local-9', email: 'local-9@noted.com', name: 'dog'),
  NotedUser(id: 'local-google', email: 'local-google@noted.com', name: 'googly_woogly'),
];

/// A list of [String]s that are accepted as passwords for all [_localUsers].
List<String> _localPasswords = [
  'local',
];
