import 'package:flutter/material.dart';
import 'package:noted_app/catalog/pages/text_style_page.dart';

sealed class CatalogNode {
  final String title;

  CatalogNode({required this.title});
}

class CatalogBranch extends CatalogNode {
  final List<CatalogNode> children;

  CatalogBranch({required super.title, required this.children});
}

class CatalogLeaf extends CatalogNode {
  final Widget page;

  CatalogLeaf({required super.title, required this.page});
}

class CatalogContent {
  static final CatalogNode content = CatalogBranch(
    title: "catalog",
    children: <CatalogNode>[
      CatalogLeaf(title: "text styles", page: const TextStylePage()),
      CatalogLeaf(title: "svg images", page: const TextStylePage()),
    ],
  );
}
