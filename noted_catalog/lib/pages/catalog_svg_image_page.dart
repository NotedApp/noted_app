import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noted_catalog/catalog_list_widget.dart';

class CatalogSvgImagePage extends StatelessWidget {
  const CatalogSvgImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorFilter filter = ColorFilter.mode(Theme.of(context).colorScheme.tertiary, BlendMode.srcIn);

    List<CatalogListItem> children = [
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'woman reading',
        child: SvgPicture.asset('assets/svg/woman_reading.svg', colorFilter: filter, fit: BoxFit.fitWidth),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'woman climbing',
        child: SvgPicture.asset('assets/svg/woman_climbing.svg', colorFilter: filter, fit: BoxFit.fitWidth),
      ),
    ];

    return CatalogListWidget(children);
  }
}
