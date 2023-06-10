import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:noted_app/widget/common/button/noted_icon_button.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_toolbar.dart';
import 'package:noted_app/widget/common/rich_text/quill/quill_rich_text_controller.dart';

class QuillRichTextToolbar extends NotedRichTextToolbar {
  const QuillRichTextToolbar({required super.controller, super.key});

  @override
  Widget build(BuildContext context) {
    if (super.controller is! QuillRichTextController) {
      throw ArgumentError("A quill rich text toolbar must have a QuillController as its controller.");
    }

    QuillController controller = (super.controller as QuillRichTextController).controller;
    ColorScheme colors = Theme.of(context).colorScheme;

    return QuillToolbar(
      toolbarSize: 100,
      color: colors.secondary,
      toolbarIconAlignment: WrapAlignment.spaceBetween,
      children: [
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.bold,
          colors: colors,
          icon: NotedIcons.bold,
        ),
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.italic,
          colors: colors,
          icon: NotedIcons.italic,
        ),
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.underline,
          colors: colors,
          icon: NotedIcons.underline,
        ),
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.strikeThrough,
          colors: colors,
          icon: NotedIcons.strikethrough,
        ),
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.h1,
          colors: colors,
          icon: NotedIcons.h1,
        ),
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.h2,
          colors: colors,
          icon: NotedIcons.h2,
        ),
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.h3,
          colors: colors,
          icon: NotedIcons.h3,
        ),
        // TODO: Text color button.
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.bold,
          colors: colors,
          icon: NotedIcons.textColor,
        ),
        // TODO: Background color button.
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.bold,
          colors: colors,
          icon: NotedIcons.backgroundColor,
        ),
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.ul,
          colors: colors,
          icon: NotedIcons.unorderedList,
        ),
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.ol,
          colors: colors,
          icon: NotedIcons.orderedList,
        ),
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.checked,
          colors: colors,
          icon: NotedIcons.taskList,
        ),
        // TODO: Image button.
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.bold,
          colors: colors,
          icon: NotedIcons.camera,
        ),
        // TODO: Video button.
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.bold,
          colors: colors,
          icon: NotedIcons.video,
        ),
        // TODO: Recording button.
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.bold,
          colors: colors,
          icon: NotedIcons.mic,
        ),
        // TODO: Link button.
        QuillSwitchButton(
          controller: controller,
          attribute: Attribute.bold,
          colors: colors,
          icon: NotedIcons.link,
        ),
      ],
    );
  }
}

class QuillSwitchButton extends StatelessWidget {
  final QuillController controller;
  final Attribute attribute;
  final ColorScheme colors;
  final IconData icon;

  const QuillSwitchButton({
    required this.controller,
    required this.attribute,
    required this.colors,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleStyleButton(
      attribute: attribute,
      icon: icon,
      controller: controller,
      childBuilder: (
        context,
        attribute,
        icon,
        fillColor,
        isToggled,
        onPressed,
        afterPressed, [
        iconSize = 22,
        iconTheme,
      ]) =>
          Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: NotedIconButton(
          icon: icon,
          type: NotedIconButtonType.simple,
          iconColor: isToggled ?? false ? colors.secondary : colors.tertiary,
          backgroundColor: isToggled ?? false ? colors.tertiary : colors.secondary,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
