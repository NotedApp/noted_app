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
        iconColor: colors.onPrimary,
        backgroundColor: colors.primary,
      ),
      IconButtonRow(
        label: 'filled medium',
        size: NotedIconButtonSize.medium,
        type: NotedIconButtonType.filled,
        iconColor: colors.onSecondary,
        backgroundColor: colors.secondary,
      ),
      IconButtonRow(
        label: 'filled small',
        size: NotedIconButtonSize.small,
        type: NotedIconButtonType.filled,
        iconColor: colors.onTertiary,
        backgroundColor: colors.tertiary,
      ),
      IconButtonRow(
        label: 'filled outline large',
        size: NotedIconButtonSize.large,
        type: NotedIconButtonType.filled,
        iconColor: colors.onPrimary,
        backgroundColor: colors.primary,
        strokeWidth: 1,
      ),
      IconButtonRow(
        label: 'filled outline medium',
        size: NotedIconButtonSize.medium,
        type: NotedIconButtonType.filled,
        iconColor: colors.onSecondary,
        backgroundColor: colors.secondary,
        strokeWidth: 1,
      ),
      IconButtonRow(
        label: 'filled outline small',
        size: NotedIconButtonSize.small,
        type: NotedIconButtonType.filled,
        iconColor: colors.onTertiary,
        backgroundColor: colors.tertiary,
        strokeWidth: 1,
      ),
      IconButtonRow(
        label: 'standard large',
        size: NotedIconButtonSize.large,
        type: NotedIconButtonType.standard,
        iconColor: colors.onBackground,
      ),
      IconButtonRow(
        label: 'standard medium',
        size: NotedIconButtonSize.medium,
        type: NotedIconButtonType.standard,
        iconColor: colors.onBackground,
      ),
      IconButtonRow(
        label: 'standard small',
        size: NotedIconButtonSize.small,
        type: NotedIconButtonType.standard,
        iconColor: colors.onBackground,
      ),
      IconButtonRow(
        label: 'standard outline large',
        size: NotedIconButtonSize.large,
        type: NotedIconButtonType.standard,
        iconColor: colors.onBackground,
        strokeWidth: 1,
      ),
      IconButtonRow(
        label: 'standard outline medium',
        size: NotedIconButtonSize.medium,
        type: NotedIconButtonType.standard,
        iconColor: colors.onBackground,
        strokeWidth: 1,
      ),
      IconButtonRow(
        label: 'standard outline small',
        size: NotedIconButtonSize.small,
        type: NotedIconButtonType.standard,
        iconColor: colors.onBackground,
        strokeWidth: 1,
      ),
    ];

    return CatalogListWidget(children);
  }
}

class IconButtonRow extends StatelessWidget {
  final NotedIconButtonSize size;
  final NotedIconButtonType type;
  final Color iconColor;
  final Color? backgroundColor;
  final String label;
  final double strokeWidth;

  const IconButtonRow({
    required this.label,
    required this.size,
    required this.type,
    required this.iconColor,
    this.backgroundColor,
    this.strokeWidth = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NotedIconButton(
          () => null,
          NotedIcons.pencil,
          size: size,
          type: type,
          iconColor: iconColor,
          backgroundColor: backgroundColor,
          strokeWidth: strokeWidth,
          heroTag: label,
        ),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
