import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_controller.dart';
import 'package:noted_app/widget/common/rich_text/toolbar/noted_rich_text_color_button.dart';
import 'package:noted_app/widget/common/rich_text/toolbar/noted_rich_text_link_button.dart';
import 'package:noted_app/widget/common/rich_text/toolbar/noted_rich_text_toggle_button.dart';

class NotedRichTextToolbar extends StatelessWidget {
  final NotedRichTextController controller;

  const NotedRichTextToolbar({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: colors.onBackground.withAlpha(64),
            offset: const Offset(0, -1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 4,
        runSpacing: 6,
        children: [
          NotedRichTextToggleButton(
            controller: controller,
            attribute: NotedRichTextAttribute.bold,
            colors: colors,
          ),
          NotedRichTextToggleButton(
            controller: controller,
            attribute: NotedRichTextAttribute.italic,
            colors: colors,
          ),
          NotedRichTextToggleButton(
            controller: controller,
            attribute: NotedRichTextAttribute.underline,
            colors: colors,
          ),
          NotedRichTextToggleButton(
            controller: controller,
            attribute: NotedRichTextAttribute.strikethrough,
            colors: colors,
          ),
          NotedRichTextToggleButton(
            controller: controller,
            attribute: NotedRichTextAttribute.h1,
            colors: colors,
          ),
          NotedRichTextToggleButton(
            controller: controller,
            attribute: NotedRichTextAttribute.h2,
            colors: colors,
          ),
          NotedRichTextToggleButton(
            controller: controller,
            attribute: NotedRichTextAttribute.h3,
            colors: colors,
          ),
          NotedRichTextToggleButton(
            controller: controller,
            attribute: NotedRichTextAttribute.ul,
            colors: colors,
          ),
          NotedRichTextToggleButton(
            controller: controller,
            attribute: NotedRichTextAttribute.ol,
            colors: colors,
          ),
          NotedRichTextToggleButton(
            controller: controller,
            attribute: NotedRichTextAttribute.taskList,
            colors: colors,
          ),
          NotedRichTextColorButton(
            controller: controller,
            attribute: NotedRichTextAttribute.textColor,
            colors: colors,
          ),
          NotedRichTextColorButton(
            controller: controller,
            attribute: NotedRichTextAttribute.textBackground,
            colors: colors,
          ),
          NotedRichTextLinkButton(
            controller: controller,
            colors: colors,
          ),
        ],
      ),
    );
  }
}
