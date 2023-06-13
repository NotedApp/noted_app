import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/button/noted_icon_button.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';
import 'package:noted_app/widget/common/rich_text/appflowy/appflowy_rich_text_toolbar.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_attributes.dart';
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

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 4,
        runSpacing: 6,
        children: [
          NotedRichTextButton.toggle(
            icon: NotedIcons.bold,
            colors: colors,
            isToggled: controller.isAttributeToggled(NotedRichTextAttribute.bold),
            onPressed: () => controller.toggleAttribute(NotedRichTextAttribute.bold),
          ),
        ],
      ),
    );
  }
}

class NotedRichTextButton extends StatelessWidget {
  final IconData icon;
  final ColorScheme colors;
  final bool isToggled;
  final VoidCallback onPressed;

  const NotedRichTextButton.toggle({
    required this.icon,
    required this.colors,
    required this.isToggled,
    required this.onPressed,
    super.key,
  });

  const NotedRichTextButton.action({
    required this.icon,
    required this.colors,
    required this.onPressed,
    super.key,
  }) : isToggled = false;

  @override
  Widget build(BuildContext context) {
    return NotedIconButton(
      icon: icon,
      type: NotedIconButtonType.simple,
      iconColor: isToggled ? colors.secondary : colors.tertiary,
      backgroundColor: isToggled ? colors.tertiary : colors.secondary,
      onPressed: onPressed,
    );
  }
}
