import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';

class CatalogTextStylePage extends StatelessWidget {
  const CatalogTextStylePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    List<Widget> children = [
      TextRow(theme.displayLarge, 'display large'),
      TextRow(theme.displayMedium, 'display medium'),
      TextRow(theme.displaySmall, 'display small'),
      TextRow(theme.headlineLarge, 'headline large'),
      TextRow(theme.headlineMedium, 'headline medium'),
      TextRow(theme.headlineSmall, 'headline small'),
      TextRow(theme.titleLarge, 'title large'),
      TextRow(theme.titleMedium, 'title medium'),
      TextRow(theme.titleSmall, 'title small'),
      TextRow(theme.labelLarge, 'label large'),
      TextRow(theme.labelMedium, 'label medium'),
      TextRow(theme.labelSmall, 'label small'),
      TextRow(theme.bodyLarge, 'body large'),
      TextRow(theme.bodyMedium, 'body medium'),
      TextRow(theme.bodySmall, 'body small'),
    ];

    return CatalogListWidget(children);
  }
}

class TextRow extends StatelessWidget {
  final TextStyle? style;
  final String label;

  final TextStyle defaultStyle = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.normal,
    color: Colors.red,
  );

  const TextRow(this.style, this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('noted.', style: style),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
