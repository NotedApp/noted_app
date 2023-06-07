import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:noted_app/theme/color_schemes.dart';
import 'package:noted_app/theme/text_themes.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/noted_error.dart';

final class ThemeState extends Equatable {
  final NotedColorSchemeName colorSchemeName;
  final NotedTextThemeName textThemeName;
  final ColorScheme customColorScheme;
  final NotedError? error;

  ColorScheme get colorScheme => NotedColorSchemes.fromName(colorSchemeName);
  TextTheme get textTheme => NotedTextThemes.fromName(textThemeName);

  ThemeData get themeData => ThemeData(
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme,
        textButtonTheme: _createTextButtonTheme(textTheme, colorScheme),
        useMaterial3: true,
      );

  const ThemeState(this.colorSchemeName, this.textThemeName, this.customColorScheme, {this.error});

  ThemeState.initial()
      : colorSchemeName = NotedColorSchemeName.blue,
        textThemeName = NotedTextThemeName.poppins,
        customColorScheme = NotedColorSchemes.fromName(NotedColorSchemeName.blue),
        error = null;

  ThemeState copyWith({
    NotedColorSchemeName? colorSchemeName,
    NotedTextThemeName? textThemeName,
    ColorScheme? customColorScheme,
    NotedError? error,
  }) {
    return ThemeState(
      colorSchemeName ?? this.colorSchemeName,
      textThemeName ?? this.textThemeName,
      customColorScheme ?? this.customColorScheme,
      error: error,
    );
  }

  TextButtonThemeData _createTextButtonTheme(TextTheme text, ColorScheme colors) {
    return TextButtonThemeData(style: ButtonStyle(backgroundColor: colors.primary.materialState()));
  }

  @override
  List<Object> get props => [colorSchemeName, textThemeName, customColorScheme, error ?? 'null'];
}
