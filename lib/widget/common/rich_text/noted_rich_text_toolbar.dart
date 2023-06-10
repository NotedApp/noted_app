import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_controller.dart';

abstract class NotedRichTextToolbar extends StatelessWidget {
  final NotedRichTextController controller;

  const NotedRichTextToolbar({required this.controller, super.key});
}
