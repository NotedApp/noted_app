import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/settings/local_settings_repository.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_app/state/settings/settings_event.dart';
import 'package:noted_app/state/settings/settings_state.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/environment/environment.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

void main() {
  group('SettingsBloc', () {
    LocalSettingsRepository getRepository() {
      return locator<SettingsRepository>() as LocalSettingsRepository;
    }

    setUpAll(() {
      LocalEnvironment().configure();
    });

    setUp(() {
      getRepository().reset();
      getRepository().setMsDelay(1);
    });

    blocTest(
      'loads user',
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(SettingsLoadUserEvent('test')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        SettingsState(status: SettingsStatus.loading, settings: NotedSettings()),
        SettingsState(settings: NotedSettings()),
      ],
    );

    blocTest(
      'loads user and handles error',
      setUp: () async {
        getRepository().setShouldThrow(true);
      },
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(SettingsLoadUserEvent('test')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        SettingsState(status: SettingsStatus.loading, settings: NotedSettings()),
        SettingsState(settings: NotedSettings(), error: NotedException(ErrorCode.settings_fetch_failed)),
      ],
    );

    blocTest(
      'updates current color scheme name',
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(SettingsUpdateStyleColorSchemeEvent('test', NotedColorSchemeName.green)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        SettingsState(
          settings: NotedSettings(style: NotedStyleSettings(currentColorSchemeName: NotedColorSchemeName.green)),
        ),
      ],
    );

    blocTest(
      'updates current color scheme name and handles error',
      setUp: () async {
        getRepository().setShouldThrow(true);
      },
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(SettingsUpdateStyleColorSchemeEvent('test', NotedColorSchemeName.green)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        SettingsState(
          settings: NotedSettings(style: NotedStyleSettings(currentColorSchemeName: NotedColorSchemeName.green)),
        ),
        SettingsState(
          settings: NotedSettings(style: NotedStyleSettings(currentColorSchemeName: NotedColorSchemeName.green)),
          error: NotedException(ErrorCode.settings_updateStyle_failed),
        ),
      ],
    );

    blocTest(
      'updates custom color scheme',
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(SettingsUpdateStyleCustomColorSchemeEvent('test', NotedColorScheme.green)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        SettingsState(
          settings: NotedSettings(style: NotedStyleSettings(customColorScheme: NotedColorScheme.green)),
        ),
      ],
    );

    blocTest(
      'updates custom color scheme and handles error',
      setUp: () async {
        getRepository().setShouldThrow(true);
      },
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(SettingsUpdateStyleCustomColorSchemeEvent('test', NotedColorScheme.green)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        SettingsState(
          settings: NotedSettings(style: NotedStyleSettings(customColorScheme: NotedColorScheme.green)),
        ),
        SettingsState(
          settings: NotedSettings(style: NotedStyleSettings(customColorScheme: NotedColorScheme.green)),
          error: NotedException(ErrorCode.settings_updateStyle_failed),
        ),
      ],
    );

    blocTest(
      'updates current text theme',
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(SettingsUpdateStyleTextThemeEvent('test', NotedTextTheme.roboto)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        SettingsState(
          settings: NotedSettings(style: NotedStyleSettings(textTheme: NotedTextTheme.roboto)),
        ),
      ],
    );

    blocTest(
      'updates current text theme and handles error',
      setUp: () async {
        getRepository().setShouldThrow(true);
      },
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(SettingsUpdateStyleTextThemeEvent('test', NotedTextTheme.roboto)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        SettingsState(
          settings: NotedSettings(style: NotedStyleSettings(textTheme: NotedTextTheme.roboto)),
        ),
        SettingsState(
          settings: NotedSettings(style: NotedStyleSettings(textTheme: NotedTextTheme.roboto)),
          error: NotedException(ErrorCode.settings_updateStyle_failed),
        ),
      ],
    );
  });
}
