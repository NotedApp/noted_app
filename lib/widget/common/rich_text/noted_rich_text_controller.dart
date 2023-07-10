import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/widget/common/rich_text/quill/quill_rich_text_controller.dart';
import 'package:noted_models/noted_models.dart';

abstract class NotedRichTextController extends ChangeNotifier {
  NotedRichTextController();

  factory NotedRichTextController.quill({NotedDocument? initial}) {
    return QuillRichTextController(initial: initial);
  }

  bool isAttributeToggled(NotedRichTextAttribute attribute);

  void setAttribute(NotedRichTextAttribute attribute, bool value);

  Color? getColor(NotedRichTextAttribute attribute);

  void setColor(NotedRichTextAttribute attribute, Color? value);

  String? getLink();

  void setLink(String? value);

  void insertEmbed(NotedRichTextEmbed embed);
}
