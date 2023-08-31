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
      NotedSettings settings = await repository.fetchSettings(userId: 'test');
      expect(settings, NotedSettings());

      NotedStyleSettings style = NotedStyleSettings(
        colorSchemeName: NotedColorSchemeName.green,
        textThemeName: NotedTextThemeName.roboto,
      );

      await repository.updateStyleSettings(userId: 'test', style: style);
      NotedSettings updated = await repository.fetchSettings(userId: 'test');

      expect(updated.style.colorSchemeName, NotedColorSchemeName.green);
      expect(updated.style.textThemeName, NotedTextThemeName.roboto);
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
        () => repository.updateStyleSettings(userId: 'test', style: NotedStyleSettings()),
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

      NotedSettings settings = await repository.fetchSettings(userId: 'test');
      expect(settings, NotedSettings());
    });
  });
}
