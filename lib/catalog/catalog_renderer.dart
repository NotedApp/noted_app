import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_content.dart';

class CatalogRenderer extends StatelessWidget {
  final CatalogNode _node;
  final bool _isRoot;

  const CatalogRenderer(this._node, {bool isRoot = false, super.key}) : _isRoot = isRoot;

  @override
  Widget build(BuildContext context) {
    switch (_node) {
      case CatalogBranch branch:
        return _buildBranch(branch, context);
      case CatalogLeaf leaf:
        return _buildLeaf(leaf, context);
    }
  }

  Widget _buildBranch(CatalogBranch branch, BuildContext context) {}

  Widget _buildLeaf(CatalogLeaf leaf, BuildContext context) {}
}
