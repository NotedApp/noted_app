import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/theme/color_schemes.dart';
import 'package:noted_app/theme/text_themes.dart';

class ThemeCubit extends Cubit<ThemeData> {
  static final ThemeData _defaultTheme = ThemeData(
    colorScheme: NotedColorSchemes.blueColorScheme,
    textTheme: NotedTextThemes.poppinsTextTheme,
    useMaterial3: true,
  );

  ThemeCubit() : super(_defaultTheme);

  void updateColorScheme(NotedColorSchemeName schemeName) {
    ColorScheme scheme = switch (schemeName) {
      NotedColorSchemeName.blue => NotedColorSchemes.blueColorScheme,
      NotedColorSchemeName.green => NotedColorSchemes.greenColorScheme,
      NotedColorSchemeName.dark => NotedColorSchemes.darkColorScheme,
      NotedColorSchemeName.oled => NotedColorSchemes.oledColorScheme,
      NotedColorSchemeName.custom => NotedColorSchemes.customColorScheme,
      _ => NotedColorSchemes.blueColorScheme
    };

    emit(state.copyWith(colorScheme: scheme));
  }

  void updateTextTheme(NotedTextThemeName themeName) {
    TextTheme theme = switch (themeName) {
      NotedTextThemeName.poppins => NotedTextThemes.poppinsTextTheme,
      NotedTextThemeName.roboto => NotedTextThemes.robotoTextTheme,
      NotedTextThemeName.lora => NotedTextThemes.loraTextTheme,
      NotedTextThemeName.poppins => NotedTextThemes.poppinsTextTheme,
      _ => NotedTextThemes.poppinsTextTheme
    };

    emit(state.copyWith(textTheme: theme));
  }
}
