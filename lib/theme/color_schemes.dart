import 'package:flutter/material.dart';

enum NotedColorSchemeName {
  blue,
  green,
  dark,
  oled,
  light,
  custom,
}

class NotedColorSchemes {
  static ColorScheme fromName(NotedColorSchemeName name) {
    return switch (name) {
      NotedColorSchemeName.blue => blueColorScheme,
      NotedColorSchemeName.green => greenColorScheme,
      NotedColorSchemeName.dark => darkColorScheme,
      NotedColorSchemeName.oled => oledColorScheme,
      NotedColorSchemeName.light => lightColorScheme,
      NotedColorSchemeName.custom => customColorScheme,
    };
  }

  static const ColorScheme blueColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF8DA5A5),
    onPrimary: Color(0xFF111111),
    secondary: Color(0xFFAFC0C0),
    onSecondary: Color(0xFF111111),
    tertiary: Color(0xFF2A324B),
    onTertiary: Color(0xFFE5E3C9),
    error: Color(0xFFB33951),
    onError: Color(0xFFEEEEEE),
    background: Color(0xFFE5E3C9),
    onBackground: Color(0xFF111111),
    surface: Color(0xFFCECCB5),
    onSurface: Color(0xFF111111),
  );

  static const ColorScheme greenColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF90A578),
    onPrimary: Color(0xFF111111),
    secondary: Color(0xFFAEBE9D),
    onSecondary: Color(0xFF111111),
    tertiary: Color(0xFF526241),
    onTertiary: Color(0xFFE5E3C9),
    error: Color(0xFFB33951),
    onError: Color(0xFFEEEEEE),
    background: Color(0xFFE5E3C9),
    onBackground: Color(0xFF111111),
    surface: Color(0xFFCECCB5),
    onSurface: Color(0xFF111111),
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF789395),
    onPrimary: Color(0xFF111111),
    secondary: Color(0xFF495883),
    onSecondary: Color(0xFFEEEEEE),
    tertiary: Color(0xFF98ADAE),
    onTertiary: Color(0xFF111111),
    error: Color(0xFFB33951),
    onError: Color(0xFFEEEEEE),
    background: Color(0xFF121212),
    onBackground: Color(0xFFEEEEEE),
    surface: Color(0xFF1A1A1A),
    onSurface: Color(0xFFEEEEEE),
  );

  static const ColorScheme oledColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF789395),
    onPrimary: Color(0xFF000000),
    secondary: Color(0xFF495883),
    onSecondary: Color(0xFFEEEEEE),
    tertiary: Color(0xFF98ADAE),
    onTertiary: Color(0xFF000000),
    error: Color(0xFFB33951),
    onError: Color(0xFFEEEEEE),
    background: Color(0xFF000000),
    onBackground: Color(0xFFEEEEEE),
    surface: Color(0xFF181818),
    onSurface: Color(0xFFEEEEEE),
  );

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF90A578),
    onPrimary: Color(0xFF111111),
    secondary: Color(0xFFAEBE9D),
    onSecondary: Color(0xFF111111),
    tertiary: Color(0xFF526241),
    onTertiary: Color(0xFFEEEEEE),
    error: Color(0xFFB33951),
    onError: Color(0xFFEEEEEE),
    background: Color(0xFFFFFFFF),
    onBackground: Color(0xFF111111),
    surface: Color(0xFFE6E6E6),
    onSurface: Color(0xFF111111),
  );

  // TODO: Ensure that the color scheme can be modified when implementing theme settings.
  static const ColorScheme customColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF789395),
    onPrimary: Color(0xFF111111),
    secondary: Color(0xFF98ADAE),
    onSecondary: Color(0xFF111111),
    tertiary: Color(0xFF2A324B),
    onTertiary: Color(0xFFE5E3C9),
    error: Color(0xFFB33951),
    onError: Color(0xFFEEEEEE),
    background: Color(0xFFE5E3C9),
    onBackground: Color(0xFF111111),
    surface: Color(0xFFCECCB5),
    onSurface: Color(0xFF111111),
  );
}
