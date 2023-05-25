import 'package:flutter/material.dart';

enum CatalogListItemType {
  row,
  column,
}

class CatalogListWidget extends StatelessWidget {
  final List<CatalogListItem> children;

  const CatalogListWidget(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      itemBuilder: (context, index) => children[index],
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
        child: Divider(color: Theme.of(context).colorScheme.tertiary),
      ),
      itemCount: children.length,
    );
  }
}

class CatalogListItem extends StatelessWidget {
  final CatalogListItemType type;
  final String label;
  final EdgeInsets padding;
  final Widget child;

  const CatalogListItem({
    this.type = CatalogListItemType.row,
    required this.label,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? titleStyle = Theme.of(context).textTheme.titleMedium;

    return Padding(
      padding: padding,
      child: switch (type) {
        CatalogListItemType.row => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              child,
              Text(label, style: titleStyle),
            ],
          ),
        CatalogListItemType.column => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: double.infinity, height: 36, child: Text(label, style: titleStyle)),
              child,
            ],
          ),
      },
    );
  }
}
