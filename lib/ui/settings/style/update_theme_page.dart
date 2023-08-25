import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_app/state/settings/settings_event.dart';
import 'package:noted_app/state/settings/settings_state.dart';
import 'package:noted_app/ui/common/icon/noted_icons.dart';
import 'package:noted_app/ui/common/layout/noted_card.dart';
import 'package:noted_app/ui/common/layout/noted_header_page.dart';
import 'package:noted_app/ui/common/noted_widget_config.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

class UpdateThemePage extends StatelessWidget {
  List<NotedColorSchemeName> get names => NotedColorSchemeName.values;

  const UpdateThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsBloc bloc = context.read<SettingsBloc>();
    Strings strings = context.strings();

    return NotedHeaderPage(
      title: strings.settings_style_themeTitle,
      hasBackButton: true,
      child: BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) =>
            previous.settings.style.colorSchemeName != current.settings.style.colorSchemeName,
        builder: (context, state) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 128),
          itemBuilder: (context, index) {
            ColorScheme colors = NotedColorScheme.fromName(
              names[index],
              state.settings.style.customColorScheme,
            ).toMaterial();

            return ThemeSwitcherItem(
              title: _getSchemeName(strings, names[index]),
              colors: colors,
              isSelected: state.settings.style.colorSchemeName == names[index],
              onTap: () => bloc.add(SettingsUpdateStyleColorSchemeEvent(names[index])),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: names.length,
        ),
      ),
    );
  }

  String _getSchemeName(Strings strings, NotedColorSchemeName name) {
    return switch (name) {
      NotedColorSchemeName.blue => strings.settings_style_blue,
      NotedColorSchemeName.green => strings.settings_style_green,
      NotedColorSchemeName.dark => strings.settings_style_dark,
      NotedColorSchemeName.oled => strings.settings_style_oled,
      NotedColorSchemeName.light => strings.settings_style_light,
      NotedColorSchemeName.custom => strings.settings_style_custom,
    };
  }
}

class ThemeSwitcherItem extends StatelessWidget {
  final String title;
  final ColorScheme colors;
  final bool isSelected;
  final VoidCallback? onTap;

  const ThemeSwitcherItem({
    required this.title,
    required this.colors,
    this.isSelected = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle? titleStyle = theme.textTheme.headlineMedium?.copyWith(color: colors.onBackground);

    return NotedCard(
      size: NotedWidgetSize.medium,
      onTap: onTap,
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
