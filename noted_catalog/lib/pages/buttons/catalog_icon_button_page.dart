import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_catalog/catalog_list_widget.dart';

class CatalogIconButtonPage extends StatelessWidget {
  const CatalogIconButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    List<CatalogListItem> children = [
      CatalogListItem(
        label: 'filled',
        type: CatalogListItemType.column,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              size: NotedWidgetSize.large,
              type: NotedIconButtonType.filled,
              color: NotedWidgetColor.primary,
            ),
            _buildItem(
              size: NotedWidgetSize.medium,
              type: NotedIconButtonType.filled,
              color: NotedWidgetColor.secondary,
            ),
            _buildItem(
              size: NotedWidgetSize.small,
              type: NotedIconButtonType.filled,
              color: NotedWidgetColor.tertiary,
            ),
          ],
        ),
      ),
      CatalogListItem(
        label: 'filled outlined',
        type: CatalogListItemType.column,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              size: NotedWidgetSize.large,
              type: NotedIconButtonType.filled,
              color: NotedWidgetColor.primary,
              outlineColor: colors.onBackground,
            ),
            _buildItem(
              size: NotedWidgetSize.medium,
              type: NotedIconButtonType.filled,
              color: NotedWidgetColor.secondary,
              outlineColor: colors.onBackground,
            ),
            _buildItem(
              size: NotedWidgetSize.small,
              type: NotedIconButtonType.filled,
              color: NotedWidgetColor.tertiary,
              outlineColor: colors.onBackground,
            ),
          ],
        ),
      ),
      CatalogListItem(
        label: 'simple',
        type: CatalogListItemType.column,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              size: NotedWidgetSize.large,
              type: NotedIconButtonType.simple,
            ),
            _buildItem(
              size: NotedWidgetSize.medium,
              type: NotedIconButtonType.simple,
            ),
            _buildItem(
              size: NotedWidgetSize.small,
              type: NotedIconButtonType.simple,
            ),
          ],
        ),
      ),
      CatalogListItem(
        label: 'simple outline',
        type: CatalogListItemType.column,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              size: NotedWidgetSize.large,
              type: NotedIconButtonType.simple,
              outlineColor: colors.onBackground,
            ),
            _buildItem(
              size: NotedWidgetSize.medium,
              type: NotedIconButtonType.simple,
              outlineColor: colors.onBackground,
            ),
            _buildItem(
              size: NotedWidgetSize.small,
              type: NotedIconButtonType.simple,
              outlineColor: colors.onBackground,
            ),
          ],
        ),
      ),
    ];

    return CatalogListWidget(children);
  }

  NotedIconButton _buildItem({
    required NotedIconButtonType type,
    required NotedWidgetSize size,
    NotedWidgetColor? color,
    Color? outlineColor,
  }) {
    return NotedIconButton(
      icon: NotedIcons.pencil,
      type: type,
      size: size,
      color: color,
      onPressed: () => {},
      outlineColor: outlineColor,
    );
  }
}
