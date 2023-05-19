import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_content.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';
import 'package:noted_app/widget/common/layout/page_header.dart';
import 'package:noted_app/widget/common/layout/tappable_row.dart';

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
            PageHeader(
              title: node.title,
              showButton: !isRoot,
              onButtonPressed: () => _tryPop(context),
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
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      itemBuilder: (context, index) => _buildBranchRow(context, branch.children[index]),
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
        child: Divider(),
      ),
      itemCount: branch.children.length,
    );
  }

  Widget _buildBranchRow(BuildContext context, CatalogNode node) {
    List<Widget> children = [Text(node.title, style: Theme.of(context).textTheme.bodyLarge)];

    if (node is CatalogBranch) {
      children.add(const Icon(NotedIcons.chevronRight));
    }

    return TappableRow(
      onTap: () => _navigateTo(context, node),
      children: children,
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
