import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/widget/common/layout/noted_card.dart';

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
        label: "card large",
        child: NotedCard(
          size: NotedCardSize.large,
          height: 128,
        ),
      ),
      const LayoutColumn(
        label: "card medium",
        child: NotedCard(
          size: NotedCardSize.medium,
          height: 96,
        ),
      ),
      const LayoutColumn(
        label: "card small",
        child: NotedCard(
          size: NotedCardSize.small,
          height: 64,
        ),
      ),
    ];

    return CatalogListWidget(children);
  }
}

class LayoutColumn extends StatelessWidget {
  final String label;
  final Widget child;

  const LayoutColumn({required this.label, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: double.infinity, height: 36, child: Text(label)),
        child,
      ],
    );
  }
}
