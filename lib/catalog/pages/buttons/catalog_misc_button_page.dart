import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/widget/common/button/noted_switch_button.dart';

class CatalogMiscButtonPage extends StatefulWidget {
  const CatalogMiscButtonPage({super.key});

  @override
  State<StatefulWidget> createState() => _CatalogMiscButtonState();
}

class _CatalogMiscButtonState extends State<CatalogMiscButtonPage> {
  bool _isSwitchSelected = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      ButtonRow(label: 'switch', content: NotedSwitchButton(value: _isSwitchSelected, onChanged: _updateSwitch)),
    ];

    return CatalogListWidget(children);
  }

  void _updateSwitch(bool selected) => setState(() => _isSwitchSelected = selected);
}

class ButtonRow extends StatelessWidget {
  final String label;
  final Widget content;

  const ButtonRow({required this.label, required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        content,
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
