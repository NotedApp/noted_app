import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/editor/noted_editor_controller.dart';
import 'package:noted_app/ui/common/editor/quill/quill_editor.dart';

abstract class NotedEditor extends StatelessWidget {
  final NotedEditorController controller;
  final FocusNode? focusNode;
  final String? placeholder;
  final bool readonly;
  final bool autofocus;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  NotedEditor({
    required this.controller,
    this.focusNode,
    this.placeholder,
    this.readonly = false,
    this.autofocus = false,
    this.padding = EdgeInsets.zero,
    this.onTap,
    super.key,
  });

  factory NotedEditor.quill({
    required NotedEditorController controller,
    FocusNode? focusNode,
    String? placeholder,
    bool readonly = false,
    bool autofocus = false,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    VoidCallback? onTap,
    Key? key,
  }) {
    return QuillEditor(
      controller: controller,
      focusNode: focusNode,
      placeholder: placeholder,
      readonly: readonly,
      autofocus: autofocus,
      padding: padding,
      onTap: onTap,
      key: key,
    );
  }
}
