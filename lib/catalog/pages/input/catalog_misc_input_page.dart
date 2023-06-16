import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/theme/custom_colors.dart';
import 'package:noted_app/widget/common/button/noted_text_button.dart';
import 'package:noted_app/widget/common/input/noted_color_picker.dart';
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

  Color selectedColor = black;

  @override
  Widget build(BuildContext context) {
    List<CatalogListItem> children = [
      CatalogListItem(
        type: CatalogListItemType.column,
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
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'dropdown no value',
        child: NotedDropdownButton(
          value: dropdownValue1,
          items: dropdownOptions1,
          onChanged: (value) => setState(() {
            dropdownValue1 = value;
          }),
        ),
      ),
      CatalogListItem(
        label: 'color picker',
        child: NotedTextButton(
          label: 'launch',
          type: NotedTextButtonType.filled,
          onPressed: launchColorPicker,
        ),
      ),
    ];

    return CatalogListWidget(children);
  }

  Future<void> launchColorPicker() async {
    Color? updated = await showColorPicker(context, selectedColor, () => setState(() => selectedColor = black));

    if (updated != null) {
      setState(() => selectedColor = updated);
    }
  }
}
