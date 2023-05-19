import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_content.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';
import 'package:noted_app/widget/common/layout/page_header.dart';

class CatalogRenderer extends StatelessWidget {
  final CatalogNode _node;
  final bool _isRoot;

  const CatalogRenderer(this._node, {bool isRoot = false, super.key}) : _isRoot = isRoot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              _node.title,
              !_isRoot,
              onButtonPressed: () => _tryPop(context),
            ),
            Expanded(
              child: switch (_node) {
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
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _navigateTo(context, node),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              node.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Icon(NotedIcons.chevronRight),
          ],
        ),
      ),
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
