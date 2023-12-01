import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/settings/local_settings_repository.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

void main() {
  late LocalSettingsRepository repository;

  setUp(() {
    repository = LocalSettingsRepository();
    repository.setMsDelay(1);
  });

  group('LocalSettingsRepository', () {
    test('fetches settings and sets settings', () async {
      SettingsModel settings = await repository.fetchSettings(userId: 'test');
      expect(settings, const SettingsModel());

      StyleSettingsModel style = const StyleSettingsModel(
        colorSchemeName: ColorSchemeModelName.green,
        textThemeName: TextThemeModelName.roboto,
      );

      TagSettingsModel tags = TagSettingsModel(
        showTags: false,
        tags: {const TagModel.empty(), const TagModel(id: 'test', name: 'test', color: 0xFFFFFFFF)},
      );

      PluginSettingsModel plugins = PluginSettingsModel(
        cookbook: CookbookSettingsModel(
          showCookTime: false,
          typeTags: {const TagModel.empty()},
        ),
      );

      await repository.updateStyleSettings(userId: 'test', style: style);
      await repository.updateTagSettings(userId: 'test', tags: tags);
      await repository.updatePluginSettings(userId: 'test', plugins: plugins);

      SettingsModel updated = await repository.fetchSettings(userId: 'test');

      expect(updated.style.colorSchemeName, ColorSchemeModelName.green);
      expect(updated.style.textThemeName, TextThemeModelName.roboto);

      expect(updated.tags.showTags, false);
      expect(updated.tags.tags.length, 2);

      expect(updated.plugins.cookbook.showCookTime, false);
      expect(updated.plugins.cookbook.typeTags.length, 1);
    });

    test('handles fetch error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.fetchSettings(userId: 'test'),
        throwsA(NotedError(ErrorCode.settings_fetch_failed)),
      );
    });

    test('handles update style error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.updateStyleSettings(userId: 'test', style: const StyleSettingsModel()),
        throwsA(NotedError(ErrorCode.settings_updateStyle_failed)),
      );
    });

    test('handles update tags error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.updateTagSettings(userId: 'test', tags: const TagSettingsModel()),
        throwsA(NotedError(ErrorCode.settings_updateTags_failed)),
      );
    });

    test('handles update plugins error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.updatePluginSettings(userId: 'test', plugins: const PluginSettingsModel()),
        throwsA(NotedError(ErrorCode.settings_updatePlugins_failed)),
      );
    });

    test('throws and resets when requested', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.fetchSettings(userId: 'test'),
        throwsA(NotedError(ErrorCode.settings_fetch_failed)),
      );

      repository.reset();

      SettingsModel settings = await repository.fetchSettings(userId: 'test');
      expect(settings, const SettingsModel());
    });
  });
}
