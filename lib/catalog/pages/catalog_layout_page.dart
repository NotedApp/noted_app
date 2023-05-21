import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/widget/common/button/noted_text_button.dart';
import 'package:noted_app/widget/common/layout/noted_card.dart';
import 'package:noted_app/widget/common/layout/noted_loading_indicator.dart';
import 'package:noted_app/widget/common/layout/noted_snack_bar.dart';

class CatalogLayoutPage extends StatefulWidget {
  const CatalogLayoutPage({super.key});

  @override
  State<StatefulWidget> createState() => _CatalogLayoutPageState();
}

class _CatalogLayoutPageState extends State<CatalogLayoutPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      const LayoutColumn(
        label: 'loading indicator',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotedLoadingIndicator(),
            SizedBox(width: 12),
            NotedLoadingIndicator(label: 'loading text'),
          ],
        ),
      ),
      const LayoutColumn(
        label: 'card large',
        child: NotedCard(
          size: NotedCardSize.large,
          height: 128,
          margin: EdgeInsets.zero,
        ),
      ),
      const LayoutColumn(
        label: 'card medium',
        child: NotedCard(
          size: NotedCardSize.medium,
          height: 96,
          margin: EdgeInsets.zero,
        ),
      ),
      const LayoutColumn(
        label: 'card small',
        child: NotedCard(
          size: NotedCardSize.small,
          height: 64,
          margin: EdgeInsets.zero,
        ),
      ),
      LayoutColumn(
        label: 'snackbar no close',
        child: Row(
          children: [
            NotedTextButton(
              label: 'open snackbar',
              type: NotedTextButtonType.filled,
              size: NotedTextButtonSize.small,
              onPressed: () => _showSnackBar(context),
            ),
            const SizedBox(width: 12),
            NotedTextButton(
              label: 'text snackbar',
              type: NotedTextButtonType.filled,
              size: NotedTextButtonSize.small,
              onPressed: () => _showTextSnackBar(context),
            ),
          ],
        ),
      ),
      LayoutColumn(
        label: 'snackbar with close',
        child: Row(
          children: [
            NotedTextButton(
              label: 'open snackbar',
              type: NotedTextButtonType.filled,
              size: NotedTextButtonSize.small,
              onPressed: () => _showSnackBar(context, hasClose: true),
            ),
            const SizedBox(width: 12),
            NotedTextButton(
              label: 'text snackbar',
              type: NotedTextButtonType.filled,
              size: NotedTextButtonSize.small,
              onPressed: () => _showTextSnackBar(context, hasClose: true),
            ),
          ],
        ),
      ),
    ];

    return CatalogListWidget(children);
  }

  void _showSnackBar(BuildContext context, {bool hasClose = false}) {
    ThemeData theme = Theme.of(context);

    Widget content = Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'test snackbar text',
        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface),
      ),
    );

    SnackBar snackBar = hasClose
        ? NotedSnackBar.createWithClose(context: context, content: content)
        : NotedSnackBar.create(context: context, content: content);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showTextSnackBar(BuildContext context, {bool hasClose = false}) {
    SnackBar snackBar = NotedSnackBar.createWithText(
      context: context,
      text: 'test snackbar with text',
      hasClose: hasClose,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class LayoutColumn extends StatelessWidget {
  final String label;
  final Widget child;

  const LayoutColumn({required this.label, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: double.infinity, height: 36, child: Text(label)),
        child,
      ],
    );
  }
}
