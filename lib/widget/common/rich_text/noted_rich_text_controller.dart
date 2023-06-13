import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/rich_text/appflowy/appflowy_rich_text_controller.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/widget/common/rich_text/quill/quill_rich_text_controller.dart';

abstract class NotedRichTextController extends ChangeNotifier {
  NotedRichTextController();

  factory NotedRichTextController.quill() {
    return QuillRichTextController();
  }

  factory NotedRichTextController.appflowy() {
    return AppflowyRichTextController();
  }

  void toggleAttribute(NotedRichTextAttribute attribute);

  bool isAttributeToggled(NotedRichTextAttribute attribute);

  void insertEmbed(NotedRichTextEmbed embed);
}
