import 'package:flutter/material.dart';
import 'package:noted_app/ui/router/route_error_page.dart';
import 'package:noted_catalog/pages/buttons/catalog_icon_button_page.dart';
import 'package:noted_catalog/pages/buttons/catalog_misc_button_page.dart';
import 'package:noted_catalog/pages/buttons/catalog_text_button_page.dart';
import 'package:noted_catalog/pages/catalog_icons_page.dart';
import 'package:noted_catalog/pages/catalog_layout_page.dart';
import 'package:noted_catalog/pages/catalog_svg_image_page.dart';
import 'package:noted_catalog/pages/catalog_text_style_page.dart';
import 'package:noted_catalog/pages/catalog_tiles_page.dart';
import 'package:noted_catalog/pages/input/catalog_misc_input_page.dart';
import 'package:noted_catalog/pages/input/catalog_text_input_page.dart';
import 'package:noted_catalog/pages/editor/catalog_quill_editor.dart';

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
    title: 'catalog',
    children: [
      CatalogLeaf(title: 'text', page: const CatalogTextStylePage()),
      CatalogLeaf(title: 'images', page: const CatalogSvgImagePage()),
      CatalogLeaf(title: 'icons', page: const CatalogIconsPage()),
      CatalogLeaf(title: 'tiles', page: const CatalogTilesPage()),
      CatalogLeaf(title: 'layout', page: const CatalogLayoutPage()),
      CatalogLeaf(title: 'editor', page: const CatalogQuillEditor()),
      CatalogBranch(title: 'buttons', children: [
        CatalogLeaf(title: 'icon', page: const CatalogIconButtonPage()),
        CatalogLeaf(title: 'text', page: const CatalogTextButtonPage()),
        CatalogLeaf(title: 'misc', page: const CatalogMiscButtonPage()),
      ]),
      CatalogBranch(title: 'input', children: [
        CatalogLeaf(title: 'text', page: const CatalogTextInputPage()),
        CatalogLeaf(title: 'misc', page: const CatalogMiscInputPage()),
      ]),
      CatalogBranch(title: 'pages', children: [
        CatalogLeaf(title: 'route error', page: const RouteErrorPage()),
      ]),
    ],
  );
}
