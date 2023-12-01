import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

/// A list of [UserModel]s who can be logged in in a local environment.
const List<UserModel> _localUsers = [
  UserModel(id: 'local-0', email: 'local-0@noted.com', name: 'shaquille.oatmeal'),
  UserModel(id: 'local-1', email: 'local-1@noted.com', name: 'averagestudent'),
  UserModel(id: 'local-2', email: 'local-2@noted.com', name: 'me_for_president'),
  UserModel(id: 'local-3', email: 'local-3@noted.com', name: 'chickenriceandbeans'),
  UserModel(id: 'local-4', email: 'local-4@noted.com', name: 'fluffycookie'),
  UserModel(id: 'local-5', email: 'local-5@noted.com', name: 'averagestudent'),
  UserModel(id: 'local-6', email: 'local-6@noted.com', name: 'LactoseTheIntolerant'),
  UserModel(id: 'local-7', email: 'local-7@noted.com', name: 'kim_chi'),
  UserModel(id: 'local-8', email: 'local-8@noted.com', name: 'just-a-harmless-potato'),
  UserModel(id: 'local-9', email: 'local-9@noted.com', name: 'dog'),
  UserModel(id: 'local-google', email: 'local-google@noted.com', name: 'googly_woogly'),
];

/// A list of [String]s that are accepted as passwords for all [_localUsers].
const List<String> _localPasswords = [
  'local',
];

/// An [AuthRepository] that uses mock data as its source of truth.
class LocalAuthRepository extends AuthRepository implements Disposable {
  final StreamController<UserModel> _userStreamController = StreamController.broadcast();
  UserModel _currentUser = const UserModel.empty();
  bool _shouldThrow = false;
  int _msDelay = 2000;

  List<UserModel> _users = [..._localUsers];
  List<String> _passwords = [..._localPasswords];

  @override
  UserModel get currentUser => _currentUser;

  @override
  Stream<UserModel> get userStream => _userStreamController.stream;

  LocalAuthRepository({UserModel user = const UserModel.empty(), int msDelay = 2000}) {
    if (user.isNotEmpty) {
      _currentUser = user;
    }

    _msDelay = msDelay;
  }

  @override
  Future<void> createUserWithEmailAndPassword({String email = '', String password = ''}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (email.length < 3) {
      throw NotedError(ErrorCode.auth_createUser_invalidEmail);
    }

    if (password.length < 3) {
      throw NotedError(ErrorCode.auth_createUser_weakPassword);
    }

    UserModel user = UserModel(
      id: 'local-${_users.length}',
      email: email,
      name: 'Local ${_users.length}',
    );

    _users.add(user);
    _passwords.add(password);

    await _updateUser(user, ErrorCode.auth_createUser_failed, delay: false);
  }

  @override
  Future<void> signInWithEmailAndPassword({String email = '', String password = ''}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    UserModel user = _users.firstWhere((user) => user.email == email, orElse: UserModel.empty);

    if (user.isEmpty) {
      throw NotedError(ErrorCode.auth_emailSignIn_invalidEmail);
    }

    if (!_passwords.contains(password)) {
      throw NotedError(ErrorCode.auth_emailSignIn_invalidPassword);
    }

    await _updateUser(user, ErrorCode.auth_emailSignIn_failed, delay: false);
  }

  @override
  Future<void> signInWithGoogle() async {
    UserModel googleUser = _users.firstWhere((user) => user.id == 'local-google');
    await _updateUser(googleUser, ErrorCode.auth_googleSignIn_failed);
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
    await _updateUser(const UserModel.empty(), ErrorCode.auth_signOut_failed);
  }

  @override
  Future<void> sendPasswordResetEmail({String email = ''}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw NotedError(ErrorCode.auth_passwordReset_failed);
    }
  }

  @override
  Future<void> changePassword({String password = ''}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw NotedError(ErrorCode.auth_changePassword_failed);
    }

    _passwords.add(password);
  }

  @override
  Future<void> deleteAccount() async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw NotedError(ErrorCode.auth_deleteAccount_failed);
    }

    _users.removeWhere((user) => user.id == _currentUser.id);
    await _updateUser(const UserModel.empty(), ErrorCode.auth_deleteAccount_failed, delay: false);
  }

  @override
  FutureOr onDispose() async {
    await _userStreamController.close();
  }

  Future<void> _updateUser(UserModel user, ErrorCode error, {bool delay = true}) async {
    if (delay) {
      await Future.delayed(Duration(milliseconds: _msDelay));
    }

    if (_shouldThrow) {
      throw NotedError(error);
    }

    _currentUser = user;
    _userStreamController.add(user);
  }

  void setShouldThrow(bool shouldThrow) => _shouldThrow = shouldThrow;
  void setMsDelay(int msDelay) => _msDelay = msDelay;
  void reset() {
    _shouldThrow = false;
    _msDelay = 2000;
    _currentUser = const UserModel.empty();
    _users = [..._localUsers];
    _passwords = [..._localPasswords];
  }
}
