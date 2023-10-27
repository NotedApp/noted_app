import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/button/noted_icon_button.dart';
import 'package:noted_app/ui/common/editor/noted_editor_attributes.dart';
import 'package:noted_app/ui/common/editor/noted_editor_controller.dart';

class NotedEditorStateButton extends StatelessWidget {
  final NotedEditorController controller;
  final NotedEditorAttribute attribute;
  final ColorScheme colors;
  final VoidCallback onPressed;

  const NotedEditorStateButton({
    required this.controller,
    required this.attribute,
    required this.colors,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NotedIconButton(
      icon: attribute.icon,
      type: NotedIconButtonType.simple,
      iconColor: colors.tertiary,
      backgroundColor: colors.secondary,
      onPressed: onPressed,
    );
  }
}
