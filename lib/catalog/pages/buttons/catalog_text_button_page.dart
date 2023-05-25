import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/widget/common/button/noted_text_button.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';

class CatalogTextButtonPage extends StatelessWidget {
  const CatalogTextButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    List<CatalogListItem> children = [
      _buildItem(
        label: 'filled large',
        type: NotedTextButtonType.filled,
        size: NotedTextButtonSize.large,
      ),
      _buildItem(
        label: 'filled large icon',
        type: NotedTextButtonType.filled,
        size: NotedTextButtonSize.large,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'filled medium',
        type: NotedTextButtonType.filled,
        size: NotedTextButtonSize.medium,
        foreground: colors.onSecondary,
        background: colors.secondary,
      ),
      _buildItem(
        label: 'filled medium icon',
        type: NotedTextButtonType.filled,
        size: NotedTextButtonSize.medium,
        foreground: colors.onSecondary,
        background: colors.secondary,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'filled small',
        type: NotedTextButtonType.filled,
        size: NotedTextButtonSize.small,
        foreground: colors.onTertiary,
        background: colors.tertiary,
      ),
      _buildItem(
        label: 'filled small icon',
        type: NotedTextButtonType.filled,
        size: NotedTextButtonSize.small,
        foreground: colors.onTertiary,
        background: colors.tertiary,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'outlined large',
        type: NotedTextButtonType.outlined,
        size: NotedTextButtonSize.large,
      ),
      _buildItem(
        label: 'outlined large icon',
        type: NotedTextButtonType.outlined,
        size: NotedTextButtonSize.large,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'outlined medium',
        type: NotedTextButtonType.outlined,
        size: NotedTextButtonSize.medium,
      ),
      _buildItem(
        label: 'outlined medium icon',
        type: NotedTextButtonType.outlined,
        size: NotedTextButtonSize.medium,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'outlined small',
        type: NotedTextButtonType.outlined,
        size: NotedTextButtonSize.small,
      ),
      _buildItem(
        label: 'outlined small icon',
        type: NotedTextButtonType.outlined,
        size: NotedTextButtonSize.small,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'simple large',
        type: NotedTextButtonType.simple,
        size: NotedTextButtonSize.large,
      ),
      _buildItem(
        label: 'simple large icon',
        type: NotedTextButtonType.simple,
        size: NotedTextButtonSize.large,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'simple medium',
        type: NotedTextButtonType.simple,
        size: NotedTextButtonSize.medium,
      ),
      _buildItem(
        label: 'simple medium icon',
        type: NotedTextButtonType.simple,
        size: NotedTextButtonSize.medium,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'simple small',
        type: NotedTextButtonType.simple,
        size: NotedTextButtonSize.small,
      ),
      _buildItem(
        label: 'simple small icon',
        type: NotedTextButtonType.simple,
        size: NotedTextButtonSize.small,
        icon: NotedIcons.pencil,
      ),
    ];

    return CatalogListWidget(children);
  }

  CatalogListItem _buildItem({
    required String label,
    required NotedTextButtonType type,
    required NotedTextButtonSize size,
    Color? foreground,
    Color? background,
    IconData? icon,
  }) {
    return CatalogListItem(
      label: label,
      child: NotedTextButton(
        label: 'noted',
        type: type,
        size: size,
        icon: icon,
        onPressed: () => {},
        foregroundColor: foreground,
        backgroundColor: background,
      ),
    );
  }
}
