import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/widget/common/button/noted_icon_button.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';

class CatalogIconButtonPage extends StatelessWidget {
  const CatalogIconButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    List<CatalogListItem> children = [
      _buildItem(
        label: 'filled large',
        size: NotedIconButtonSize.large,
        type: NotedIconButtonType.filled,
        foreground: colors.onPrimary,
        background: colors.primary,
      ),
      _buildItem(
        label: 'filled medium',
        size: NotedIconButtonSize.medium,
        type: NotedIconButtonType.filled,
        foreground: colors.onSecondary,
        background: colors.secondary,
      ),
      _buildItem(
        label: 'filled small',
        size: NotedIconButtonSize.small,
        type: NotedIconButtonType.filled,
        foreground: colors.onTertiary,
        background: colors.tertiary,
      ),
      _buildItem(
        label: 'filled outline large',
        size: NotedIconButtonSize.large,
        type: NotedIconButtonType.filled,
        foreground: colors.onPrimary,
        background: colors.primary,
        hasOutline: true,
      ),
      _buildItem(
        label: 'filled outline medium',
        size: NotedIconButtonSize.medium,
        type: NotedIconButtonType.filled,
        foreground: colors.onSecondary,
        background: colors.secondary,
        hasOutline: true,
      ),
      _buildItem(
        label: 'filled outline small',
        size: NotedIconButtonSize.small,
        type: NotedIconButtonType.filled,
        foreground: colors.onTertiary,
        background: colors.tertiary,
        hasOutline: true,
      ),
      _buildItem(
        label: 'simple large',
        size: NotedIconButtonSize.large,
        type: NotedIconButtonType.simple,
        foreground: colors.onBackground,
      ),
      _buildItem(
        label: 'simple medium',
        size: NotedIconButtonSize.medium,
        type: NotedIconButtonType.simple,
        foreground: colors.onBackground,
      ),
      _buildItem(
        label: 'simple small',
        size: NotedIconButtonSize.small,
        type: NotedIconButtonType.simple,
        foreground: colors.onBackground,
      ),
      _buildItem(
        label: 'simple outline large',
        size: NotedIconButtonSize.large,
        type: NotedIconButtonType.simple,
        foreground: colors.onBackground,
        hasOutline: true,
      ),
      _buildItem(
        label: 'simple outline medium',
        size: NotedIconButtonSize.medium,
        type: NotedIconButtonType.simple,
        foreground: colors.onBackground,
        hasOutline: true,
      ),
      _buildItem(
        label: 'simple outline small',
        size: NotedIconButtonSize.small,
        type: NotedIconButtonType.simple,
        foreground: colors.onBackground,
        hasOutline: true,
      ),
    ];

    return CatalogListWidget(children);
  }

  CatalogListItem _buildItem({
    required String label,
    required NotedIconButtonType type,
    required NotedIconButtonSize size,
    Color? foreground,
    Color? background,
    bool hasOutline = false,
  }) {
    return CatalogListItem(
      label: label,
      child: NotedIconButton(
        icon: NotedIcons.pencil,
        type: type,
        size: size,
        onPressed: () => {},
        iconColor: foreground,
        backgroundColor: background,
        hasOutline: hasOutline,
      ),
    );
  }
}
