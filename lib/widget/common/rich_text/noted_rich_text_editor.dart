import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/rich_text/appflowy/appflowy_rich_text_editor.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_controller.dart';
import 'package:noted_app/widget/common/rich_text/quill/quill_rich_text_editor.dart';

abstract class NotedRichTextEditor extends StatelessWidget {
  final NotedRichTextController controller;
  final FocusNode focusNode;
  final bool readonly;

  const NotedRichTextEditor({
    required this.controller,
    required this.focusNode,
    this.readonly = false,
    super.key,
  });

  factory NotedRichTextEditor.quill(NotedRichTextController controller, FocusNode focusNode) {
    return QuillRichTextEditor(
      controller: controller,
      focusNode: focusNode,
    );
  }

  factory NotedRichTextEditor.appflowy(NotedRichTextController controller, FocusNode focusNode) {
    return AppflowyRichTextEditor(
      controller: controller,
      focusNode: focusNode,
    );
  }
}
