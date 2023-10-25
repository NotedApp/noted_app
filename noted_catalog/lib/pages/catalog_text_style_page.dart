import 'package:flutter/material.dart';
import 'package:noted_catalog/catalog_list_widget.dart';

class CatalogTextStylePage extends StatelessWidget {
  TextStyle get defaultStyle => const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.normal,
        color: Colors.red,
      );

  const CatalogTextStylePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    List<CatalogListItem> children = [
      _buildItem(style: theme.displayLarge, label: 'display large'),
      _buildItem(style: theme.displayMedium, label: 'display medium'),
      _buildItem(style: theme.displaySmall, label: 'display small'),
      _buildItem(style: theme.headlineLarge, label: 'headline large'),
      _buildItem(style: theme.headlineMedium, label: 'headline medium'),
      _buildItem(style: theme.headlineSmall, label: 'headline small'),
      _buildItem(style: theme.titleLarge, label: 'title large'),
      _buildItem(style: theme.titleMedium, label: 'title medium'),
      _buildItem(style: theme.titleSmall, label: 'title small'),
      _buildItem(style: theme.labelLarge, label: 'label large'),
      _buildItem(style: theme.labelMedium, label: 'label medium'),
      _buildItem(style: theme.labelSmall, label: 'label small'),
      _buildItem(style: theme.bodyLarge, label: 'body large'),
      _buildItem(style: theme.bodyMedium, label: 'body medium'),
      _buildItem(style: theme.bodySmall, label: 'body small'),
    ];

    return CatalogListWidget(children);
  }

  CatalogListItem _buildItem({
    required String label,
    required TextStyle? style,
  }) {
    return CatalogListItem(
      label: label,
      child: Text('noted.', style: style ?? defaultStyle),
    );
  }
}
