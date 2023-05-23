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
  bool hide0 = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      InputColumn(
        label: 'text field show/hide',
        child: NotedTextField(
          type: NotedTextFieldType.standard,
          name: 'email',
          errorText: error0,
          showErrorText: true,
          controller: controller0,
          obscureText: hide0,
          onSubmitted: (_) => setState(() {
            error0 = validateText(controller0.text);
          }),
          icon: hide0 ? NotedIcons.eye : NotedIcons.eyeClosed,
          onIconPressed: () => setState(() {
            hide0 = !hide0;
          }),
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
