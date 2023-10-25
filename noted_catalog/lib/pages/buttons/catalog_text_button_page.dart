import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_catalog/catalog_list_widget.dart';

class CatalogTextButtonPage extends StatelessWidget {
  const CatalogTextButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<CatalogListItem> children = [
      _buildItem(
        label: 'filled large',
        type: NotedTextButtonType.filled,
        size: NotedWidgetSize.large,
        color: NotedWidgetColor.primary,
      ),
      _buildItem(
        label: 'filled large icon',
        type: NotedTextButtonType.filled,
        size: NotedWidgetSize.large,
        color: NotedWidgetColor.secondary,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'filled medium',
        type: NotedTextButtonType.filled,
        size: NotedWidgetSize.medium,
        color: NotedWidgetColor.tertiary,
      ),
      _buildItem(
        label: 'filled medium icon',
        type: NotedTextButtonType.filled,
        size: NotedWidgetSize.medium,
        color: NotedWidgetColor.primary,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'filled small',
        type: NotedTextButtonType.filled,
        size: NotedWidgetSize.small,
        color: NotedWidgetColor.secondary,
      ),
      _buildItem(
        label: 'filled small icon',
        type: NotedTextButtonType.filled,
        size: NotedWidgetSize.small,
        color: NotedWidgetColor.tertiary,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'outlined large',
        type: NotedTextButtonType.outlined,
        size: NotedWidgetSize.large,
      ),
      _buildItem(
        label: 'outlined large icon',
        type: NotedTextButtonType.outlined,
        size: NotedWidgetSize.large,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'outlined medium',
        type: NotedTextButtonType.outlined,
        size: NotedWidgetSize.medium,
      ),
      _buildItem(
        label: 'outlined medium icon',
        type: NotedTextButtonType.outlined,
        size: NotedWidgetSize.medium,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'outlined small',
        type: NotedTextButtonType.outlined,
        size: NotedWidgetSize.small,
      ),
      _buildItem(
        label: 'outlined small icon',
        type: NotedTextButtonType.outlined,
        size: NotedWidgetSize.small,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'simple large',
        type: NotedTextButtonType.simple,
        size: NotedWidgetSize.large,
      ),
      _buildItem(
        label: 'simple large icon',
        type: NotedTextButtonType.simple,
        size: NotedWidgetSize.large,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'simple medium',
        type: NotedTextButtonType.simple,
        size: NotedWidgetSize.medium,
      ),
      _buildItem(
        label: 'simple medium icon',
        type: NotedTextButtonType.simple,
        size: NotedWidgetSize.medium,
        icon: NotedIcons.pencil,
      ),
      _buildItem(
        label: 'simple small',
        type: NotedTextButtonType.simple,
        size: NotedWidgetSize.small,
      ),
      _buildItem(
        label: 'simple small icon',
        type: NotedTextButtonType.simple,
        size: NotedWidgetSize.small,
        icon: NotedIcons.pencil,
      ),
    ];

    return CatalogListWidget(children);
  }

  CatalogListItem _buildItem({
    required String label,
    required NotedTextButtonType type,
    required NotedWidgetSize size,
    NotedWidgetColor? color,
    IconData? icon,
  }) {
    return CatalogListItem(
      label: label,
      child: NotedTextButton(
        label: 'noted',
        type: type,
        size: size,
        color: color,
        icon: icon,
        onPressed: () => {},
      ),
    );
  }
}
