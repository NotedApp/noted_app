import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_content.dart';
import 'package:noted_app/catalog/catalog_renderer.dart';

void main() {
  runApp(const CatalogApp());
}

class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'noted catalog',
      theme: ,
      home: Scaffold(body: CatalogRenderer(CatalogContent.content, isRoot: true)),
    );
  }
}