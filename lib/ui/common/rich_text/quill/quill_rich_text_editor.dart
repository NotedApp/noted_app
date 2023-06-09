import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_editor.dart';
import 'package:noted_app/ui/common/rich_text/quill/quill_rich_text_controller.dart';

class QuillRichTextEditor extends NotedRichTextEditor {
  const QuillRichTextEditor({
    required super.controller,
    super.focusNode,
    super.placeholder,
    super.readonly,
    super.padding,
    super.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (controller is! QuillRichTextController) {
      throw ArgumentError('A quill rich text editor must have a QuillController as its controller.');
    }

    ThemeData theme = Theme.of(context);
    QuillController quillController = (controller as QuillRichTextController).controller;

    return QuillEditor(
      controller: quillController,
      focusNode: focusNode ?? FocusNode(),
      scrollController: ScrollController(),
      scrollable: true,
      padding: padding,
      autoFocus: false,
      readOnly: readonly,
      expands: true,
      placeholder: placeholder,
      showCursor: !readonly,
      keyboardAppearance: theme.brightness,
      onTapUp: _handleTap,
    );
  }

  bool _handleTap(TapUpDetails details, TextPosition Function(Offset) position) {
    QuillController quillController = (controller as QuillRichTextController).controller;

    if (quillController.selection.baseOffset == quillController.selection.extentOffset) {
      onTap?.call();
    }

    return false;
  }
}
