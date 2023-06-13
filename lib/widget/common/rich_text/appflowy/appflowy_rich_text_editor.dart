import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/rich_text/appflowy/appflowy_rich_text_controller.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_editor.dart';

class AppflowyRichTextEditor extends NotedRichTextEditor {
  const AppflowyRichTextEditor({
    required super.controller,
    required super.focusNode,
    super.readonly,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (controller is! AppflowyRichTextController) {
      throw ArgumentError("An appflowy rich text editor must have a AppflowyController as its controller.");
    }

    EditorState editorState = (controller as AppflowyRichTextController).editorState;
    return AppFlowyEditor.standard(
      editorStyle: const EditorStyle.mobile(),
      editorState: editorState,
      focusNode: focusNode,
      editable: !readonly,
    );
  }
}
