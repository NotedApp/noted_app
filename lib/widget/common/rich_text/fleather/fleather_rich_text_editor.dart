import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/rich_text/fleather/fleather_rich_text_controller.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_editor.dart';

class FleatherRichTextEditor extends NotedRichTextEditor {
  const FleatherRichTextEditor({
    required super.controller,
    required super.focusNode,
    super.readonly,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (super.controller is! FleatherRichTextController) {
      throw ArgumentError("A fleather rich text editor must have a FleatherController as its controller.");
    }

    FleatherController controller = (super.controller as FleatherRichTextController).controller;
    return FleatherEditor(
      controller: controller,
      focusNode: super.focusNode,
      scrollController: ScrollController(),
      scrollable: true,
      padding: EdgeInsets.zero,
      autofocus: false,
      readOnly: super.readonly,
      expands: true,
    );
  }
}
