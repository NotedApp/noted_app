import 'package:firebase_core/firebase_core.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/firebase_auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/environment/test_firebase_options.dart';
import 'package:noted_app/util/logging/firebase_logger.dart';
import 'package:noted_app/util/logging/local_logger.dart';
import 'package:noted_app/util/logging/noted_logger.dart';

sealed class Environment {
  Future<void> configure();
}

class LocalEnvironment extends Environment {
  @override
  Future<void> configure() async {
    _registerDependencies();
  }

  void _registerDependencies() {
    // Utilities.
    locator.registerSingleton<NotedLogger>(LocalLogger());

    // Repositories.
    locator.registerSingleton<AuthRepository>(LocalAuthRepository());

    // Blocs.
  }
}

class TestEnvironment extends Environment {
  @override
  Future<void> configure() async {
    await Firebase.initializeApp(options: TestFirebaseOptions.currentPlatform);

    _registerDependencies();
  }

  void _registerDependencies() {
    // Utilities.
    locator.registerSingleton<NotedLogger>(FirebaseLogger());

    // Repositories.
    locator.registerSingleton<AuthRepository>(FirebaseAuthRepository());
  }
}

class ProdEnvironment extends Environment {
  @override
  Future<void> configure() async {
    throw UnimplementedError();
  }
}
