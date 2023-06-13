import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/rich_text/appflowy/appflowy_rich_text_controller.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_toolbar.dart';

class AppflowyRichTextToolbar extends NotedRichTextToolbar {
  const AppflowyRichTextToolbar({required super.controller, super.key});

  @override
  Widget build(BuildContext context) {
    if (super.controller is! AppflowyRichTextController) {
      throw ArgumentError("An appflowy rich text toolbar must have a AppflowyController as its controller.");
    }

    // EditorState editorState = (controller as AppflowyRichTextController).editorState;
    // ColorScheme colors = Theme.of(context).colorScheme;

    return const SizedBox(
      height: 1,
      width: 1,
    );
/*
    return FleatherToolbar(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
      children: [
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.bold,
          colors: colors,
          icon: NotedIcons.bold,
        ),
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.italic,
          colors: colors,
          icon: NotedIcons.italic,
        ),
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.underline,
          colors: colors,
          icon: NotedIcons.underline,
        ),
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.strikethrough,
          colors: colors,
          icon: NotedIcons.strikethrough,
        ),
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.h1,
          colors: colors,
          icon: NotedIcons.h1,
        ),
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.h2,
          colors: colors,
          icon: NotedIcons.h2,
        ),
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.h3,
          colors: colors,
          icon: NotedIcons.h3,
        ),
        // TODO: Text color button.
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.bold,
          colors: colors,
          icon: NotedIcons.textColor,
        ),
        // TODO: Background color button.
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.bold,
          colors: colors,
          icon: NotedIcons.backgroundColor,
        ),
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.ul,
          colors: colors,
          icon: NotedIcons.unorderedList,
        ),
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.ol,
          colors: colors,
          icon: NotedIcons.orderedList,
        ),
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.checked,
          colors: colors,
          icon: NotedIcons.taskList,
        ),
        // TODO: Image button.
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.bold,
          colors: colors,
          icon: NotedIcons.camera,
        ),
        // TODO: Video button.
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.bold,
          colors: colors,
          icon: NotedIcons.video,
        ),
        // TODO: Recording button.
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.bold,
          colors: colors,
          icon: NotedIcons.mic,
        ),
        // TODO: Link button.
        FleatherToggleButton(
          controller: controller,
          attribute: ParchmentAttribute.bold,
          colors: colors,
          icon: NotedIcons.link,
        ),
      ],
    );*/
  }
}

/*
class FleatherToggleButton extends StatelessWidget {
  final FleatherController controller;
  final ParchmentAttribute attribute;
  final ColorScheme colors;
  final IconData icon;

  const FleatherToggleButton({
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
        isToggled,
        onPressed,
      ) =>
          NotedIconButton(
        icon: icon,
        type: NotedIconButtonType.simple,
        iconColor: isToggled ? colors.secondary : colors.tertiary,
        backgroundColor: isToggled ? colors.tertiary : colors.secondary,
        onPressed: onPressed,
      ),
    );
  }
}
*/
