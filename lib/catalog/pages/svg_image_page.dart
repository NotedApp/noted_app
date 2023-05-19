import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';

class SvgImagePage extends StatelessWidget {
  const SvgImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorFilter filter = ColorFilter.mode(Theme.of(context).colorScheme.tertiary, BlendMode.srcIn);

    List<Widget> children = [
      SvgPicture.asset('assets/svg/woman_reading.svg', colorFilter: filter, fit: BoxFit.fitWidth),
      SvgPicture.asset('assets/svg/woman_climbing.svg', colorFilter: filter, fit: BoxFit.fitWidth),
    ];

    return CatalogListWidget(children);
  }
}
