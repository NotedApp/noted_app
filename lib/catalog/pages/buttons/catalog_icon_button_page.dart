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
      CatalogListItem(
        label: 'filled',
        type: CatalogListItemType.column,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItem(
              size: NotedIconButtonSize.large,
              type: NotedIconButtonType.filled,
              color: NotedIconButtonColor.primary,
            ),
            _buildItem(
              size: NotedIconButtonSize.medium,
              type: NotedIconButtonType.filled,
              color: NotedIconButtonColor.secondary,
            ),
            _buildItem(
              size: NotedIconButtonSize.small,
              type: NotedIconButtonType.filled,
              color: NotedIconButtonColor.tertiary,
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
              size: NotedIconButtonSize.large,
              type: NotedIconButtonType.filled,
              color: NotedIconButtonColor.primary,
              outlineColor: colors.onBackground,
            ),
            _buildItem(
              size: NotedIconButtonSize.medium,
              type: NotedIconButtonType.filled,
              color: NotedIconButtonColor.secondary,
              outlineColor: colors.onBackground,
            ),
            _buildItem(
              size: NotedIconButtonSize.small,
              type: NotedIconButtonType.filled,
              color: NotedIconButtonColor.tertiary,
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
              size: NotedIconButtonSize.large,
              type: NotedIconButtonType.simple,
            ),
            _buildItem(
              size: NotedIconButtonSize.medium,
              type: NotedIconButtonType.simple,
            ),
            _buildItem(
              size: NotedIconButtonSize.small,
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
              size: NotedIconButtonSize.large,
              type: NotedIconButtonType.simple,
              outlineColor: colors.onBackground,
            ),
            _buildItem(
              size: NotedIconButtonSize.medium,
              type: NotedIconButtonType.simple,
              outlineColor: colors.onBackground,
            ),
            _buildItem(
              size: NotedIconButtonSize.small,
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
    required NotedIconButtonSize size,
    NotedIconButtonColor? color,
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
