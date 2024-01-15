import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_catalog/catalog_list_widget.dart';

class CatalogSvgImagePage extends StatelessWidget {
  const CatalogSvgImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<CatalogListItem> children = [
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'woman reading',
        child: NotedSvg.asset(
          source: 'assets/svg/woman_reading.svg',
          fit: BoxFit.fitWidth,
          color: context.colorScheme().tertiary,
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'woman climbing',
        child: NotedSvg.asset(
          source: 'assets/svg/woman_climbing.svg',
          fit: BoxFit.fitWidth,
          color: context.colorScheme().tertiary,
        ),
      ),
    ];

    return CatalogListWidget(children);
  }
}
