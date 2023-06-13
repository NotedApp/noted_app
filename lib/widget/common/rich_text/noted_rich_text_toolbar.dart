import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/rich_text/appflowy/appflowy_rich_text_toolbar.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_controller.dart';
import 'package:noted_app/widget/common/rich_text/quill/quill_rich_text_toolbar.dart';

abstract class NotedRichTextToolbar extends StatelessWidget {
  final NotedRichTextController controller;

  const NotedRichTextToolbar({required this.controller, super.key});

  factory NotedRichTextToolbar.quill(NotedRichTextController controller) {
    return QuillRichTextToolbar(controller: controller);
  }

  factory NotedRichTextToolbar.appflowy(NotedRichTextController controller) {
    return AppflowyRichTextToolbar(controller: controller);
  }
}
