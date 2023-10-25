import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_catalog/catalog_list_widget.dart';

class CatalogMiscButtonPage extends StatefulWidget {
  const CatalogMiscButtonPage({super.key});

  @override
  State<StatefulWidget> createState() => _CatalogMiscButtonState();
}

class _CatalogMiscButtonState extends State<CatalogMiscButtonPage> {
  bool _isSwitchSelected = false;

  @override
  Widget build(BuildContext context) {
    List<CatalogListItem> children = [
      CatalogListItem(label: 'switch', child: NotedSwitchButton(value: _isSwitchSelected, onChanged: _updateSwitch)),
    ];

    return CatalogListWidget(children);
  }

  void _updateSwitch(bool selected) => setState(() => _isSwitchSelected = selected);
}
