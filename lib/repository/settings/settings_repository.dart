import 'package:noted_models/noted_models.dart';

/// A repository that handles user settings.
abstract class SettingsRepository {
  /// Fetches a user's settings.
  Future<NotedSettings> fetchSettings({required String userId});

  /// Updates a user's settings.
  Future<void> updateSettings({required String userId, required NotedSettings settings});
}
