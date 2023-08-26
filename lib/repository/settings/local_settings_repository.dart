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

  LocalSettingsRepository({int msDelay = 2000}) {
    _msDelay = msDelay;
  }

  @override
  Future<NotedSettings> fetchSettings({required String userId}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedException(ErrorCode.settings_fetch_failed);
    }

    return _settings.copyWith();
  }

  @override
  Future<void> updateStyleSettings({required String userId, required NotedStyleSettings style}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedException(ErrorCode.settings_updateStyle_failed);
    }

    _settings = _settings.copyWith(style: style);
  }

  void setShouldThrow(bool shouldThrow) => _shouldThrow = shouldThrow;
  void setMsDelay(int msDelay) => _msDelay = msDelay;
  void reset() {
    _shouldThrow = false;
    _msDelay = 2000;
    _settings = _localSettings.copyWith();
  }
}
