import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/layout/noted_loading_indicator.dart';

class CatalogQuillInputPage extends StatefulWidget {
  const CatalogQuillInputPage({super.key});

  @override
  State<StatefulWidget> createState() => _CatalogQuillInputPageState();
}

class _CatalogQuillInputPageState extends State<CatalogQuillInputPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: NotedLoadingIndicator());
  }
}
