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
      expect(settings, SettingsModel());

      StyleSettingsModel style = StyleSettingsModel(
        colorSchemeName: ColorSchemeModelName.green,
        textThemeName: TextThemeModelName.roboto,
      );

      await repository.updateStyleSettings(userId: 'test', style: style);
      SettingsModel updated = await repository.fetchSettings(userId: 'test');

      expect(updated.style.colorSchemeName, ColorSchemeModelName.green);
      expect(updated.style.textThemeName, TextThemeModelName.roboto);
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
        () => repository.updateStyleSettings(userId: 'test', style: StyleSettingsModel()),
        throwsA(NotedError(ErrorCode.settings_updateStyle_failed)),
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
      expect(settings, SettingsModel());
    });
  });
}
