import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/theme/theme_state.dart';
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
    emit(state.copyWith(error: NotedException(ErrorCode.state_theme_customFetchFailed)));
  }

  void updateCustomColorScheme(ColorScheme customScheme) {
    emit(state.copyWith(customColorScheme: customScheme));
  }
}
