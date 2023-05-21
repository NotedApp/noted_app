import 'package:flutter/material.dart';
import 'package:noted_app/catalog/pages/buttons/catalog_icon_button_page.dart';
import 'package:noted_app/catalog/pages/buttons/catalog_misc_button_page.dart';
import 'package:noted_app/catalog/pages/buttons/catalog_text_button_page.dart';
import 'package:noted_app/catalog/pages/catalog_color_scheme_page.dart';
import 'package:noted_app/catalog/pages/catalog_icons_page.dart';
import 'package:noted_app/catalog/pages/catalog_layout_page.dart';
import 'package:noted_app/catalog/pages/catalog_svg_image_page.dart';
import 'package:noted_app/catalog/pages/catalog_text_style_page.dart';
import 'package:noted_app/catalog/pages/catalog_text_theme_page.dart';

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
    children: [
      CatalogLeaf(title: "color", page: const CatalogColorSchemePage()),
      CatalogLeaf(title: "text", page: const CatalogTextThemePage()),
      CatalogLeaf(title: "text styles", page: const CatalogTextStylePage()),
      CatalogLeaf(title: "images", page: const CatalogSvgImagePage()),
      CatalogLeaf(title: "icons", page: const CatalogIconsPage()),
      CatalogLeaf(title: "layout", page: CatalogLayoutPage()),
      CatalogBranch(title: "buttons", children: [
        CatalogLeaf(title: "icon", page: const CatalogIconButtonPage()),
        CatalogLeaf(title: "text", page: const CatalogTextButtonPage()),
        CatalogLeaf(title: "misc", page: const CatalogMiscButtonPage()),
      ])
    ],
  );
}
