import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';
import 'package:noted_app/widget/common/input/noted_text_field.dart';

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

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      InputColumn(
        label: 'text field plain',
        child: NotedTextField(
          type: NotedTextFieldType.standard,
          name: 'email',
          errorText: error0,
          controller: controller0,
          onSubmitted: (_) => setState(() {
            error0 = validateText(controller0.text);
          }),
        ),
      ),
      InputColumn(
        label: 'text field show/hide',
        child: NotedTextField(
          type: NotedTextFieldType.standard,
          name: 'email',
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
      InputColumn(
        label: 'title text field',
        child: NotedTextField(
          type: NotedTextFieldType.title,
          hint: 'title',
          controller: controller3,
        ),
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
