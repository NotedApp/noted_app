import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/button/noted_icon_button.dart';
import 'package:noted_app/ui/common/input/noted_color_picker.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_controller.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_utils.dart';

class NotedRichTextColorsButton extends StatelessWidget {
  final NotedRichTextController controller;
  final NotedRichTextAttribute attribute;
  final ColorScheme colors;

  const NotedRichTextColorsButton({
    required this.controller,
    required this.attribute,
    required this.colors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NotedIconButton(
      icon: getAttributeIcon(attribute),
      type: NotedIconButtonType.simple,
      iconColor: colors.tertiary,
      backgroundColor: colors.secondary,
      onPressed: () => setColor(context),
    );
  }

  Future<void> setColor(BuildContext context) async {
    Color? updated = await showColorPicker(
      context,
      controller.getColor(attribute) ?? colors.onBackground,
      () => controller.setColor(attribute, null),
    );

    if (updated != null) {
      controller.setColor(attribute, updated);
    }
  }
}
