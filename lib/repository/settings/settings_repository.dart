import 'package:noted_models/noted_models.dart';

/// A repository that handles user settings.
abstract class SettingsRepository {
  /// Fetches a user's settings.
  Future<SettingsModel> fetchSettings({required String userId});

  /// Updates a user's style settings.
  Future<void> updateStyleSettings({required String userId, required StyleSettingsModel style});

  /// Updates a user's tag settings.
  Future<void> updateTagSettings({required String userId, required TagSettingsModel tags});

  /// Updates a user's tag settings.
  Future<void> updatePluginSettings({required String userId, required PluginSettingsModel plugins});
}
