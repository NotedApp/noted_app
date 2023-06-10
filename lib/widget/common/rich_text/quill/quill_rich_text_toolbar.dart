import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_toolbar.dart';
import 'package:noted_app/widget/common/rich_text/quill/quill_rich_text_controller.dart';

class QuillRichTextToolbar extends NotedRichTextToolbar {
  const QuillRichTextToolbar({required super.controller, super.key});

  @override
  Widget build(BuildContext context) {
    if (super.controller is! QuillRichTextController) {
      throw ArgumentError("A quill rich text toolbar must have a QuillController as its controller.");
    }

    QuillController controller = (super.controller as QuillRichTextController).controller;
    return QuillToolbar.basic(controller: controller);
  }
}
