import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_catalog/catalog_list_widget.dart';

class CatalogTextInputPage extends StatefulWidget {
  const CatalogTextInputPage({super.key});

  @override
  State<StatefulWidget> createState() => _CatalogTextInputPageState();
}

class _CatalogTextInputPageState extends State<CatalogTextInputPage> {
  final TextEditingController controller0 = TextEditingController();
  String? error0;

  final TextEditingController controller1 = TextEditingController();
  String? error1;
  bool hide1 = false;

  final TextEditingController controller3 = TextEditingController();

  final TextEditingController controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<CatalogListItem> children = [
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'text field plain',
        child: NotedTextField(
          type: NotedTextFieldType.outlined,
          name: 'email',
          errorText: error0,
          controller: controller0,
          onSubmitted: (_) => setState(() {
            error0 = validateText(controller0.text);
          }),
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'text field show/hide',
        child: NotedTextField(
          type: NotedTextFieldType.outlined,
          name: 'password',
          errorText: error1,
          showErrorText: true,
          controller: controller1,
          obscureText: hide1,
          onSubmitted: (_) => setState(() {
            error1 = validateText(controller1.text);
          }),
          icon: hide1 ? NotedIcons.eye : NotedIcons.eyeClosed,
          onIconPressed: () => setState(() {
            hide1 = !hide1;
          }),
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'title text field',
        child: NotedTextField(
          type: NotedTextFieldType.title,
          hint: 'title',
          controller: controller3,
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'search bar',
        child: NotedSearchBar(controller: controller4),
      ),
    ];

    return CatalogListWidget(children);
  }

  @override
  void dispose() {
    controller0.dispose();
    super.dispose();
  }

  String? validateText(String? text) {
    if (text == null || text.isEmpty) {
      return 'an empty message creates an error';
    }

    if (text.contains('error')) {
      return 'typing "error" creates an error';
    }

    return null;
  }
}
