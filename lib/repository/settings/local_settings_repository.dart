import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

/// Default local settings.
const SettingsModel _localSettings = SettingsModel();

/// A [SettingsRepository] that uses mock data as its source of truth.
class LocalSettingsRepository extends SettingsRepository {
  SettingsModel _settings = _localSettings.copyWith();
  bool _shouldThrow = false;
  int _msDelay = 2000;

  LocalSettingsRepository({int msDelay = 2000}) {
    _msDelay = msDelay;
  }

  @override
  Future<SettingsModel> fetchSettings({required String userId}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedError(ErrorCode.settings_fetch_failed);
    }

    return _settings.copyWith();
  }

  @override
  Future<void> updateStyleSettings({required String userId, required StyleSettingsModel style}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedError(ErrorCode.settings_updateStyle_failed);
    }

    _settings = _settings.copyWith(style: style);
  }

  @override
  Future<void> updateTagSettings({required String userId, required TagSettingsModel tags}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedError(ErrorCode.settings_updateTags_failed);
    }

    _settings = _settings.copyWith(tags: tags);
  }

  @override
  Future<void> updatePluginSettings({required String userId, required PluginSettingsModel plugins}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedError(ErrorCode.settings_updatePlugins_failed);
    }

    _settings = _settings.copyWith(plugins: plugins);
  }

  void setShouldThrow(bool shouldThrow) => _shouldThrow = shouldThrow;
  void setMsDelay(int msDelay) => _msDelay = msDelay;
  void reset() {
    _shouldThrow = false;
    _msDelay = 2000;
    _settings = _localSettings.copyWith();
  }
}
