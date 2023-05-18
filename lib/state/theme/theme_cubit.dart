import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/theme/color_schemes.dart';
import 'package:noted_app/theme/text_themes.dart';
import 'package:noted_app/util/noted_error.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void updateColorScheme(NotedColorSchemeName schemeName) {
    emit(state.copyWith(colorSchemeName: schemeName));
  }

  void updateTextTheme(NotedTextThemeName themeName) {
    emit(state.copyWith(textThemeName: themeName));
  }

  void fetchCustomColorScheme() {
    // TODO: Actually fetch state from remote here.
    emit(state.copyWith(error: NotedError('theme_cubit.custom_fetch_failed')));
  }

  void updateCustomColorScheme(ColorScheme customScheme) {
    emit(state.copyWith(customColorScheme: customScheme));
  }
}

final class ThemeState extends Equatable {
  final NotedColorSchemeName colorSchemeName;
  final NotedTextThemeName textThemeName;
  final ColorScheme customColorScheme;
  final NotedError? error;

  ColorScheme get colorScheme => NotedColorSchemes.fromName(colorSchemeName);
  TextTheme get textTheme => NotedTextThemes.fromName(textThemeName);

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

  @override
  List<Object> get props => [colorSchemeName, textThemeName, customColorScheme, error ?? 'null'];
}
