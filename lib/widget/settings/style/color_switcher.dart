import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/theme/theme_cubit.dart';
import 'package:noted_app/state/theme/theme_state.dart';
import 'package:noted_app/theme/color_schemes.dart';
import 'package:noted_app/util/noted_strings.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';
import 'package:noted_app/widget/common/layout/noted_card.dart';
import 'package:noted_app/widget/common/layout/noted_header_page.dart';

class ColorSwitcher extends StatelessWidget {
  final List<NotedColorSchemeName> names = NotedColorSchemeName.values;

  const ColorSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeCubit cubit = context.read<ThemeCubit>();

    return NotedHeaderPage(
      title: NotedStrings.settings['themeTitle'],
      hasBackButton: true,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 128),
          itemBuilder: (context, index) {
            ColorScheme colors = NotedColorSchemes.fromName(names[index]);
            return ColorSwitcherItem(
              title: NotedStrings.settings[names[index].toString()] ?? 'unknown',
              colors: colors,
              isSelected: state.colorSchemeName == names[index],
              onTap: () => cubit.updateColorScheme(names[index]),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemCount: names.length,
        ),
      ),
    );
  }
}

class ColorSwitcherItem extends StatelessWidget {
  final String title;
  final ColorScheme colors;
  final bool isSelected;
  final VoidCallback? onTap;

  const ColorSwitcherItem({
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
    List<Widget> titleChildren = [Text(title, style: titleStyle)];

    if (isSelected) {
      titleChildren.add(Icon(
        NotedIcons.check,
        size: 36,
        color: colors.onBackground,
      ));
    }

    return NotedCard(
      size: NotedCardSize.medium,
      onTap: onTap,
      color: colors.background,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: titleChildren),
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
