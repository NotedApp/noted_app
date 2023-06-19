import 'package:flutter/material.dart';
import 'package:noted_app/util/noted_strings.dart';
import 'package:noted_app/widget/common/input/noted_text_field.dart';
import 'package:noted_app/widget/common/layout/noted_dialog.dart';

class NotedStringPicker extends StatefulWidget {
  final String initialValue;
  final String? title;

  const NotedStringPicker({required this.initialValue, this.title, super.key});

  @override
  State<StatefulWidget> createState() => _NotedStringPickerState();
}

class _NotedStringPickerState extends State<NotedStringPicker> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return NotedDialog(
      title: widget.title,
      leftActionText: NotedStrings.getString(NotedStringDomain.common, 'confirm'),
      onLeftActionPressed: () => Navigator.of(context).pop(controller.text.isNotEmpty ? controller.text : null),
      rightActionText: NotedStrings.getString(NotedStringDomain.common, 'cancel'),
      onRightActionPressed: () => Navigator.of(context).pop(),
      child: NotedTextField(
        type: NotedTextFieldType.standard,
        controller: controller,
        keyboardType: TextInputType.url,
        autocorrect: false,
      ),
    );
  }
}

Future<String?> showStringPicker(
  BuildContext context,
  String initialValue, {
  String? title,
}) {
  return showDialog(
    context: context,
    builder: (_) => NotedStringPicker(
      title: title,
      initialValue: initialValue,
    ),
  );
}
