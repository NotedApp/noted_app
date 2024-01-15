import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_app/state/settings/settings_event.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/settings/style/style_frame.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class StyleThemePage extends StatelessWidget {
  List<ColorSchemeModelName> get names => ColorSchemeModelName.values;

  const StyleThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsBloc bloc = context.watch<SettingsBloc>();
    Strings strings = context.strings();

    return StyleFrame(
      title: strings.settings_style_themeTitle,
      buildWhen: (previous, current) => previous.colorSchemeName != current.colorSchemeName,
      builder: (context, state) => ListView.separated(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 128),
        itemBuilder: (context, index) {
          ColorScheme colors = ColorSchemeModel.fromName(
            names[index],
            state.customColorScheme,
          ).toMaterial();

          return ThemeSwitcherItem(
            title: _getSchemeName(strings, names[index]),
            colors: colors,
            isSelected: state.colorSchemeName == names[index],
            onPressed: () => bloc.add(SettingsUpdateStyleColorSchemeEvent(names[index])),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: names.length,
      ),
    );
  }

  String _getSchemeName(Strings strings, ColorSchemeModelName name) {
    return switch (name) {
      ColorSchemeModelName.blue => strings.settings_style_blue,
      ColorSchemeModelName.green => strings.settings_style_green,
      ColorSchemeModelName.dark => strings.settings_style_dark,
      ColorSchemeModelName.oled => strings.settings_style_oled,
      ColorSchemeModelName.light => strings.settings_style_light,
      ColorSchemeModelName.custom => strings.settings_style_custom,
    };
  }
}

class ThemeSwitcherItem extends StatelessWidget {
  final String title;
  final ColorScheme colors;
  final bool isSelected;
  final VoidCallback? onPressed;

  const ThemeSwitcherItem({
    required this.title,
    required this.colors,
    this.isSelected = false,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle? titleStyle = theme.textTheme.headlineMedium?.copyWith(color: colors.onBackground);

    return NotedCard(
      size: NotedWidgetSize.medium,
      onPressed: onPressed,
      color: colors.background,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: titleStyle),
                if (isSelected)
                  Icon(
                    NotedIcons.check,
                    size: 36,
                    color: colors.onBackground,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ColorSwitcherCircle(
                  outline: colors.onBackground,
                  background: colors.primary,
                  onBackground: colors.onPrimary,
                ),
                _ColorSwitcherCircle(
                  outline: colors.onBackground,
                  background: colors.secondary,
                  onBackground: colors.onSecondary,
                ),
                _ColorSwitcherCircle(
                  outline: colors.onBackground,
                  background: colors.tertiary,
                  onBackground: colors.onTertiary,
                ),
                _ColorSwitcherCircle(
                  outline: colors.onBackground,
                  background: colors.surface,
                  onBackground: colors.onSurface,
                ),
                _ColorSwitcherCircle(
                  outline: colors.onBackground,
                  background: colors.error,
                  onBackground: colors.onError,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorSwitcherCircle extends StatelessWidget {
  final Color outline;
  final Color background;
  final Color onBackground;

  const _ColorSwitcherCircle({
    required this.outline,
    required this.background,
    required this.onBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        border: Border.all(color: outline),
        borderRadius: BorderRadius.circular(24),
        color: background,
      ),
      child: Center(
        child: Icon(
          NotedIcons.text,
          color: onBackground,
          size: 32,
        ),
      ),
    );
  }
}
