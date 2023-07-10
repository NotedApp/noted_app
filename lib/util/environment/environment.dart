import 'package:firebase_core/firebase_core.dart';
import 'package:noted_app/util/environment/test_firebase_options.dart';

sealed class Environment {
  Future<void> configure();
}

class LocalEnvironment extends Environment {
  @override
  Future<void> configure() async {
    _registerDependencies();
  }

  void _registerDependencies() {
    // TODO: implement registerDependencies
  }
}

class TestEnvironment extends Environment {
  @override
  Future<void> configure() async {
    await Firebase.initializeApp(options: TestFirebaseOptions.currentPlatform);

    _registerDependencies();
  }

  void _registerDependencies() {
    // TODO: implement registerDependencies
  }
}

class ProdEnvironment extends Environment {
  @override
  Future<void> configure() async {
    // TODO: implement configure
  }

  void _registerDependencies() {
    throw UnimplementedError();
  }
}
