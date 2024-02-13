import 'package:noted_app/repository/local_repository_config.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

/// Default local settings.
const _localSettings = SettingsModel();

/// A [SettingsRepository] that uses mock data as its source of truth.
class LocalSettingsRepository extends SettingsRepository {
  var _settings = _localSettings.copyWith();

  var _shouldThrow = false;
  var _msDelay = LocalRepositoryConfig.mockNetworkDelayMs;

  set shouldThrow(bool value) => _shouldThrow = value;
  set msDelay(int value) => _msDelay = value;

  LocalSettingsRepository({int msDelay = LocalRepositoryConfig.mockNetworkDelayMs}) {
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

  void reset() {
    shouldThrow = false;
    msDelay = LocalRepositoryConfig.mockNetworkDelayMs;

    _settings = _localSettings.copyWith();
  }
}
