import 'package:flutter/material.dart';

class CatalogListWidget extends StatelessWidget {
  final List<Widget> children;

  const CatalogListWidget(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      itemBuilder: (context, index) => children[index],
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: children.length,
    );
  }
}
