import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/button/noted_icon_button.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_controller.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_utils.dart';

class NotedRichTextStateButton extends StatelessWidget {
  final NotedRichTextController controller;
  final NotedRichTextAttribute attribute;
  final ColorScheme colors;
  final VoidCallback onPressed;

  const NotedRichTextStateButton({
    required this.controller,
    required this.attribute,
    required this.colors,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NotedIconButton(
      icon: getAttributeIcon(attribute),
      type: NotedIconButtonType.simple,
      iconColor: colors.tertiary,
      backgroundColor: colors.secondary,
      onPressed: onPressed,
    );
  }
}
