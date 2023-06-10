import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_controller.dart';

abstract class NotedRichTextEditor extends StatelessWidget {
  final NotedRichTextController controller;
  final bool readonly;

  const NotedRichTextEditor({
    required this.controller,
    this.readonly = false,
    super.key,
  });
}
