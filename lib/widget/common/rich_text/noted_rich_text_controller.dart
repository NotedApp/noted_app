import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/widget/common/rich_text/quill/quill_rich_text_controller.dart';

abstract class NotedRichTextController extends ChangeNotifier {
  NotedRichTextController();

  factory NotedRichTextController.quill() {
    return QuillRichTextController();
  }

  bool isAttributeToggled(NotedRichTextAttribute attribute);

  void setAttribute(NotedRichTextAttribute attribute, bool value);

  Color? getColor(NotedRichTextAttribute attribute);

  void setColor(NotedRichTextAttribute attribute, Color? value);

  void insertEmbed(NotedRichTextEmbed embed);
}
