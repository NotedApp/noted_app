import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/layout/noted_loading_indicator.dart';

class CatalogTextInputPage extends StatefulWidget {
  const CatalogTextInputPage({super.key});

  @override
  State<StatefulWidget> createState() => _CatalogTextInputPageState();
}

class _CatalogTextInputPageState extends State<CatalogTextInputPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: NotedLoadingIndicator());
  }
}
