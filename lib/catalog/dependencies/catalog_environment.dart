import 'package:noted_app/catalog/dependencies/catalog_router.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/repository/settings/local_settings_repository.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/environment/environment.dart';
import 'package:noted_app/util/logging/local_logger.dart';
import 'package:noted_app/util/logging/noted_logger.dart';
import 'package:noted_app/ui/router/noted_router.dart';

class CatalogEnvironment extends Environment {
  @override
  Future<void> configure({
    NotedLogger? logger,
    NotedRouter? router,
    AuthRepository? authRepository,
    SettingsRepository? settingsRepository,
  }) async {
    // Utilities.
    locator.registerSingleton<NotedLogger>(logger ?? LocalLogger());
    locator.registerSingleton<NotedRouter>(router ?? CatalogRouter());

    // Repositories.
    locator.registerSingleton<AuthRepository>(authRepository ?? LocalAuthRepository());
    locator.registerSingleton<SettingsRepository>(settingsRepository ?? LocalSettingsRepository());
  }
}
