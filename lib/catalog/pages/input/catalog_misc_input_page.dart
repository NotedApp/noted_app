import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/widget/common/input/noted_dropdown_button.dart';

class CatalogMiscInputPage extends StatefulWidget {
  const CatalogMiscInputPage({super.key});

  @override
  State<StatefulWidget> createState() => _CatalogMiscInputPageState();
}

class _CatalogMiscInputPageState extends State<CatalogMiscInputPage> {
  final List<String> dropdownOptions0 = ['option one', 'option two', 'option three', 'option four', 'option five'];
  String? dropdownValue0 = 'option one';

  final List<String> dropdownOptions1 = ['option one', 'option two', 'option three', 'option four', 'option five'];
  String? dropdownValue1;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      InputColumn(
        label: 'dropdown value',
        child: NotedDropdownButton(
          width: 200,
          value: dropdownValue0,
          items: dropdownOptions0,
          onChanged: (value) => setState(() {
            dropdownValue0 = value;
          }),
        ),
      ),
      InputColumn(
        label: 'dropdown no value',
        child: NotedDropdownButton(
          value: dropdownValue1,
          items: dropdownOptions1,
          onChanged: (value) => setState(() {
            dropdownValue1 = value;
          }),
        ),
      ),
    ];

    return CatalogListWidget(children);
  }
}

class InputColumn extends StatelessWidget {
  final String label;
  final Widget child;

  const InputColumn({required this.label, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: double.infinity, height: 36, child: Text(label)),
        child,
      ],
    );
  }
}
