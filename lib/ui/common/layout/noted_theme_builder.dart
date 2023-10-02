import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_app/state/settings/settings_state.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

class NotedThemeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeData theme) builder;

  const NotedThemeBuilder({required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (previous, current) {
        StyleSettingsModel old = previous.settings.style;
        StyleSettingsModel next = current.settings.style;
        return old.colorScheme != next.colorScheme || old.textTheme != next.textTheme;
      },
      builder: (context, state) {
        ColorScheme colorScheme = state.settings.style.colorScheme.toMaterial();
        TextTheme textTheme = state.settings.style.textTheme.toMaterial();

        return builder(
          context,
          ThemeData(
            brightness: colorScheme.brightness,
            colorScheme: colorScheme,
            textTheme: textTheme,
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
