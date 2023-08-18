import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

/// Default local settings.
const NotedSettings _localSettings = NotedSettings();

/// A [SettingsRepository] that uses mock data as its source of truth.
class LocalSettingsRepository extends SettingsRepository {
  NotedSettings _settings = _localSettings.copyWith();
  bool _shouldThrow = false;
  int _msDelay = 2000;

  @override
  Future<NotedSettings> fetchSettings({required String userId}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw NotedException(ErrorCode.settings_fetch_failed);
    }

    return _settings;
  }

  @override
  Future<void> updateSettings({required String userId, required NotedSettings settings}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow) {
      throw NotedException(ErrorCode.settings_update_failed);
    }

    _settings = settings.copyWith();
  }

  void setShouldThrow(bool shouldThrow) => _shouldThrow = shouldThrow;
  void setMsDelay(int msDelay) => _msDelay = msDelay;
  void reset() {
    _shouldThrow = false;
    _msDelay = 2000;
    _settings = _localSettings.copyWith();
  }
}
