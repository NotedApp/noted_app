import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_controller.dart';
import 'package:noted_app/ui/common/rich_text/quill/quill_rich_text_editor.dart';

abstract class NotedRichTextEditor extends StatelessWidget {
  final NotedRichTextController controller;
  final FocusNode? focusNode;
  final String? placeholder;
  final bool readonly;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const NotedRichTextEditor({
    required this.controller,
    this.focusNode,
    this.placeholder,
    this.readonly = false,
    this.padding = EdgeInsets.zero,
    this.onTap,
    super.key,
  });

  factory NotedRichTextEditor.quill({
    required NotedRichTextController controller,
    FocusNode? focusNode,
    String? placeholder,
    bool readonly = false,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    VoidCallback? onTap,
  }) {
    return QuillRichTextEditor(
      controller: controller,
      focusNode: focusNode,
      placeholder: placeholder,
      readonly: readonly,
      padding: padding,
      onTap: onTap,
    );
  }
}
