import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_editor.dart';
import 'package:noted_app/widget/common/rich_text/quill/quill_rich_text_controller.dart';

class QuillRichTextEditor extends NotedRichTextEditor {
  const QuillRichTextEditor({
    required super.controller,
    required super.focusNode,
    super.readonly,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (controller is! QuillRichTextController) {
      throw ArgumentError('A quill rich text editor must have a QuillController as its controller.');
    }

    QuillController quillController = (controller as QuillRichTextController).controller;
    return QuillEditor(
      controller: quillController,
      focusNode: super.focusNode,
      scrollController: ScrollController(),
      scrollable: true,
      padding: EdgeInsets.zero,
      autoFocus: false,
      readOnly: super.readonly,
      expands: true,
    );
  }
}
