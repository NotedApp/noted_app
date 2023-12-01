import 'package:flutter/material.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_app/state/settings/settings_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

class NotedThemeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeData theme) builder;

  const NotedThemeBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return NotedBlocSelector<SettingsBloc, SettingsState, (ColorSchemeModel, TextThemeModel)>(
      selector: (state) => (state.settings.style.colorScheme, state.settings.style.textTheme),
      builder: (context, _, state) {
        ColorScheme colorScheme = state.$1.toMaterial();
        TextTheme textTheme = state.$2.toMaterial();

        return builder(
          context,
          ThemeData(
            brightness: colorScheme.brightness,
            colorScheme: colorScheme,
            textTheme: textTheme,
            pageTransitionsTheme: NotedWidgetConfig.transitions,
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
