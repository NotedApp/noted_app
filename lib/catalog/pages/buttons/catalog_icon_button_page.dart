import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/widget/common/button/noted_icon_button.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';

class CatalogIconButtonPage extends StatelessWidget {
  const CatalogIconButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    List<Widget> children = [
      IconButtonRow(
        label: 'filled large',
        size: NotedIconButtonSize.large,
        type: NotedIconButtonType.filled,
        foregroundColor: colors.onPrimary,
        backgroundColor: colors.primary,
      ),
      IconButtonRow(
        label: 'filled medium',
        size: NotedIconButtonSize.medium,
        type: NotedIconButtonType.filled,
        foregroundColor: colors.onSecondary,
        backgroundColor: colors.secondary,
      ),
      IconButtonRow(
        label: 'filled small',
        size: NotedIconButtonSize.small,
        type: NotedIconButtonType.filled,
        foregroundColor: colors.onTertiary,
        backgroundColor: colors.tertiary,
      ),
      IconButtonRow(
        label: 'filled outline large',
        size: NotedIconButtonSize.large,
        type: NotedIconButtonType.filled,
        foregroundColor: colors.onPrimary,
        backgroundColor: colors.primary,
        hasOutline: true,
      ),
      IconButtonRow(
        label: 'filled outline medium',
        size: NotedIconButtonSize.medium,
        type: NotedIconButtonType.filled,
        foregroundColor: colors.onSecondary,
        backgroundColor: colors.secondary,
        hasOutline: true,
      ),
      IconButtonRow(
        label: 'filled outline small',
        size: NotedIconButtonSize.small,
        type: NotedIconButtonType.filled,
        foregroundColor: colors.onTertiary,
        backgroundColor: colors.tertiary,
        hasOutline: true,
      ),
      IconButtonRow(
        label: 'simple large',
        size: NotedIconButtonSize.large,
        type: NotedIconButtonType.simple,
        foregroundColor: colors.onBackground,
      ),
      IconButtonRow(
        label: 'simple medium',
        size: NotedIconButtonSize.medium,
        type: NotedIconButtonType.simple,
        foregroundColor: colors.onBackground,
      ),
      IconButtonRow(
        label: 'simple small',
        size: NotedIconButtonSize.small,
        type: NotedIconButtonType.simple,
        foregroundColor: colors.onBackground,
      ),
      IconButtonRow(
        label: 'simple outline large',
        size: NotedIconButtonSize.large,
        type: NotedIconButtonType.simple,
        foregroundColor: colors.onBackground,
        hasOutline: true,
      ),
      IconButtonRow(
        label: 'simple outline medium',
        size: NotedIconButtonSize.medium,
        type: NotedIconButtonType.simple,
        foregroundColor: colors.onBackground,
        hasOutline: true,
      ),
      IconButtonRow(
        label: 'simple outline small',
        size: NotedIconButtonSize.small,
        type: NotedIconButtonType.simple,
        foregroundColor: colors.onBackground,
        hasOutline: true,
      ),
    ];

    return CatalogListWidget(children);
  }
}

class IconButtonRow extends StatelessWidget {
  final String label;
  final NotedIconButtonType type;
  final NotedIconButtonSize size;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool hasOutline;

  const IconButtonRow({
    required this.label,
    required this.size,
    required this.type,
    this.foregroundColor,
    this.backgroundColor,
    this.hasOutline = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NotedIconButton(
          icon: NotedIcons.pencil,
          type: type,
          size: size,
          onPressed: () {},
          onLongPress: () {},
          iconColor: foregroundColor,
          backgroundColor: backgroundColor,
          hasOutline: hasOutline,
        ),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
