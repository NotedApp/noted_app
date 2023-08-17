import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/input/noted_text_field.dart';
import 'package:noted_app/ui/common/layout/noted_dialog.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/ui/router/noted_router.dart';

class NotedStringPicker extends StatefulWidget {
  final String initialValue;
  final String? title;

  const NotedStringPicker({required this.initialValue, this.title, super.key});

  @override
  State<StatefulWidget> createState() => _NotedStringPickerState();
}

class _NotedStringPickerState extends State<NotedStringPicker> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();

    return NotedDialog(
      title: widget.title,
      leftActionText: strings.common_confirm,
      onLeftActionPressed: () => context.pop(controller.text),
      rightActionText: strings.common_cancel,
      onRightActionPressed: () => context.pop(),
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
