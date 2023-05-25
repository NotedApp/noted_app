import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_content.dart';
import 'package:noted_app/widget/common/button/noted_icon_button.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';
import 'package:noted_app/widget/common/layout/noted_page_header.dart';

class CatalogRenderer extends StatelessWidget {
  final CatalogNode node;
  final bool isRoot;

  const CatalogRenderer(this.node, {this.isRoot = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            NotedPageHeader(
              title: node.title,
              leadingAction: isRoot
                  ? null
                  : NotedIconButton(
                      icon: NotedIcons.chevronLeft,
                      type: NotedIconButtonType.filled,
                      size: NotedIconButtonSize.small,
                      onPressed: () => _tryPop(context),
                    ),
            ),
            Expanded(
              child: switch (node) {
                CatalogBranch branch => _buildBranch(branch, context),
                CatalogLeaf leaf => _buildLeaf(leaf, context)
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranch(CatalogBranch branch, BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      itemBuilder: (context, index) => _buildBranchRow(context, branch.children[index]),
      itemCount: branch.children.length,
    );
  }

  Widget _buildBranchRow(BuildContext context, CatalogNode node) {
    return ListTile(
      onTap: () => _navigateTo(context, node),
      title: Text(node.title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: node is CatalogBranch ? null : const Icon(NotedIcons.chevronRight),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    );
  }

  Widget _buildLeaf(CatalogLeaf leaf, BuildContext context) {
    return leaf.page;
  }

  void _navigateTo(BuildContext context, CatalogNode node) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CatalogRenderer(node)));
  }

  void _tryPop(BuildContext context) {
    NavigatorState nav = Navigator.of(context);

    if (nav.canPop()) {
      nav.pop();
    }
  }
}
