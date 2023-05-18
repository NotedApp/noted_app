import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/state/theme/theme_cubit.dart';
import 'package:noted_app/theme/color_schemes.dart';
import 'package:noted_app/theme/text_themes.dart';
import 'package:noted_app/util/noted_error.dart';

void main() {
  group('ThemeCubit', () {
    test('initial state is blue and poppins', () {
      expect(ThemeCubit().state.colorSchemeName, NotedColorSchemeName.blue);
      expect(ThemeCubit().state.textThemeName, NotedTextThemeName.poppins);
    });

    blocTest(
      'updates color scheme',
      build: ThemeCubit.new,
      act: (bloc) => bloc.updateColorScheme(NotedColorSchemeName.green),
      expect: () => [
        const ThemeState(
          NotedColorSchemeName.green,
          NotedTextThemeName.poppins,
          NotedColorSchemes.blueColorScheme,
        ),
      ],
    );

    blocTest(
      'updates text theme',
      build: ThemeCubit.new,
      act: (bloc) => bloc.updateTextTheme(NotedTextThemeName.vollkorn),
      expect: () => [
        const ThemeState(
          NotedColorSchemeName.blue,
          NotedTextThemeName.vollkorn,
          NotedColorSchemes.blueColorScheme,
        ),
      ],
    );

    blocTest(
      'updates custom theme',
      build: ThemeCubit.new,
      act: (bloc) => bloc.updateCustomColorScheme(NotedColorSchemes.lightColorScheme),
      expect: () => [
        const ThemeState(
          NotedColorSchemeName.blue,
          NotedTextThemeName.poppins,
          NotedColorSchemes.lightColorScheme,
        ),
      ],
    );

    blocTest(
      'fetches custom theme',
      build: ThemeCubit.new,
      act: (bloc) => bloc.fetchCustomColorScheme(),
      expect: () => [
        ThemeState(
          NotedColorSchemeName.blue,
          NotedTextThemeName.poppins,
          NotedColorSchemes.blueColorScheme,
          error: NotedError('theme_cubit.custom_fetch_failed'),
        ),
      ],
    );
  });
}
