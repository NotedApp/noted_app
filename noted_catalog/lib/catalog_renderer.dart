import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_catalog/catalog_content.dart';
import 'package:noted_catalog/catalog_settings.dart';

class CatalogRenderer extends StatelessWidget {
  final CatalogNode node;
  final bool isRoot;

  const CatalogRenderer(this.node, {this.isRoot = false, super.key});

  @override
  Widget build(BuildContext context) {
    return NotedHeaderPage(
      title: node.title,
      hasBackButton: !isRoot,
      trailingActions: [
        NotedIconButton(
          icon: NotedIcons.settings,
          type: NotedIconButtonType.filled,
          size: NotedWidgetSize.small,
          onPressed: () => _navigateToSettings(context),
        ),
      ],
      child: switch (node) {
        CatalogBranch branch => _buildBranch(branch, context),
        CatalogLeaf leaf => _buildLeaf(leaf, context)
      },
    );
  }

  Widget _buildBranch(CatalogBranch branch, BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index) => _buildBranchRow(context, branch.children[index]),
      itemCount: branch.children.length,
    );
  }

  Widget _buildBranchRow(BuildContext context, CatalogNode node) {
    return ListTile(
      onTap: () => _navigateToNode(context, node),
      title: Text(node.title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: node is CatalogBranch ? null : const Icon(NotedIcons.chevronRight),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }

  Widget _buildLeaf(CatalogLeaf leaf, BuildContext context) {
    return leaf.page;
  }

  void _navigateToNode(BuildContext context, CatalogNode node) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CatalogRenderer(node)));
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CatalogSettings()));
  }
}
