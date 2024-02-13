import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/repository/settings/local_settings_repository.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_app/state/settings/settings_event.dart';
import 'package:noted_app/state/settings/settings_state.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

import '../../helpers/environment/unit_test_environment.dart';

void main() {
  group('SettingsBloc', () {
    LocalSettingsRepository settings() => locator<SettingsRepository>() as LocalSettingsRepository;
    LocalAuthRepository auth() => locator<AuthRepository>() as LocalAuthRepository;

    setUpAll(() => UnitTestEnvironment().configure());

    setUp(() async {
      settings().reset();
      settings().msDelay = 1;

      auth().reset();
      auth().msDelay = 1;
      await auth().signInWithGoogle();
    });

    blocTest(
      'loads user',
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(SettingsLoadUserEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const SettingsState(settings: SettingsModel(), status: SettingsStatus.loading),
        const SettingsState(settings: SettingsModel()),
      ],
    );

    blocTest(
      'loads user on auth change',
      build: SettingsBloc.new,
      act: (bloc) async {
        await auth().signOut();
        await auth().signInWithGoogle();
      },
      wait: const Duration(milliseconds: 20),
      expect: () => [
        const SettingsState(settings: SettingsModel()),
        const SettingsState(settings: SettingsModel(), status: SettingsStatus.loading),
        const SettingsState(settings: SettingsModel()),
      ],
    );

    blocTest(
      'loads user and handles error',
      setUp: () => settings().shouldThrow = true,
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(SettingsLoadUserEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const SettingsState(settings: SettingsModel(), status: SettingsStatus.loading),
        SettingsState(settings: const SettingsModel(), error: NotedError(ErrorCode.settings_fetch_failed)),
      ],
    );

    blocTest(
      'load user fails with no auth',
      setUp: () async => auth().signOut(),
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(SettingsLoadUserEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        SettingsState(
          settings: const SettingsModel(),
          error: NotedError(ErrorCode.settings_fetch_failed, message: 'missing auth'),
        ),
      ],
    );

    blocTest(
      'update style fails with no auth',
      setUp: () async => auth().signOut(),
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(const SettingsUpdateStyleColorSchemeEvent(ColorSchemeModelName.green)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        SettingsState(
          settings: const SettingsModel(),
          error: NotedError(ErrorCode.settings_updateStyle_failed, message: 'missing auth'),
        ),
      ],
    );

    blocTest(
      'updates current color scheme name',
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(const SettingsUpdateStyleColorSchemeEvent(ColorSchemeModelName.green)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const SettingsState(
          settings: SettingsModel(style: StyleSettingsModel(colorSchemeName: ColorSchemeModelName.green)),
        ),
      ],
    );

    blocTest(
      'updates current color scheme name and handles error',
      setUp: () => settings().shouldThrow = true,
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(const SettingsUpdateStyleColorSchemeEvent(ColorSchemeModelName.green)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const SettingsState(
          settings: SettingsModel(style: StyleSettingsModel(colorSchemeName: ColorSchemeModelName.green)),
        ),
        SettingsState(
          settings: const SettingsModel(style: StyleSettingsModel(colorSchemeName: ColorSchemeModelName.green)),
          error: NotedError(ErrorCode.settings_updateStyle_failed),
        ),
      ],
    );

    blocTest(
      'updates custom color scheme',
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(const SettingsUpdateStyleCustomColorSchemeEvent(ColorSchemeModel.green)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const SettingsState(
          settings: SettingsModel(style: StyleSettingsModel(customColorScheme: ColorSchemeModel.green)),
        ),
      ],
    );

    blocTest(
      'updates custom color scheme and handles error',
      setUp: () => settings().shouldThrow = true,
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(const SettingsUpdateStyleCustomColorSchemeEvent(ColorSchemeModel.green)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const SettingsState(
          settings: SettingsModel(style: StyleSettingsModel(customColorScheme: ColorSchemeModel.green)),
        ),
        SettingsState(
          settings: const SettingsModel(style: StyleSettingsModel(customColorScheme: ColorSchemeModel.green)),
          error: NotedError(ErrorCode.settings_updateStyle_failed),
        ),
      ],
    );

    blocTest(
      'updates current text theme',
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(const SettingsUpdateStyleTextThemeEvent(TextThemeModelName.roboto)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const SettingsState(
          settings: SettingsModel(style: StyleSettingsModel(textThemeName: TextThemeModelName.roboto)),
        ),
      ],
    );

    blocTest(
      'updates current text theme and handles error',
      setUp: () => settings().shouldThrow = true,
      build: SettingsBloc.new,
      act: (bloc) => bloc.add(const SettingsUpdateStyleTextThemeEvent(TextThemeModelName.roboto)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const SettingsState(
          settings: SettingsModel(style: StyleSettingsModel(textThemeName: TextThemeModelName.roboto)),
        ),
        SettingsState(
          settings: const SettingsModel(style: StyleSettingsModel(textThemeName: TextThemeModelName.roboto)),
          error: NotedError(ErrorCode.settings_updateStyle_failed),
        ),
      ],
    );
  });
}
