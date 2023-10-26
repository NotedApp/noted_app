import 'package:noted_models/noted_models.dart';

/// A repository that handles user settings.
abstract class SettingsRepository {
  /// Fetches a user's settings.
  Future<SettingsModel> fetchSettings({required String userId});

  /// Updates a user's style settings.
  Future<void> updateStyleSettings({required String userId, required StyleSettingsModel style});
}
