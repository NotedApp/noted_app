import 'package:noted_models/noted_models.dart';

/// A repository that handles user settings.
abstract class SettingsRepository {
  /// Fetches a user's settings.
  Future<NotedSettings> fetchSettings({required String userId});

  /// Updates a user's style settings.
  Future<void> updateStyleSettings({required String userId, required NotedStyleSettings style});
}
