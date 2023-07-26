part of '../noted_rich_text_toolbar.dart';

class _ToolbarHome extends StatelessWidget {
  final NotedRichTextController controller;

  const _ToolbarHome({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return Wrap(
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
        NotedRichTextColorsButton(
          controller: controller,
          attribute: NotedRichTextAttribute.textColor,
          colors: colors,
        ),
        NotedRichTextColorsButton(
          controller: controller,
          attribute: NotedRichTextAttribute.textBackground,
          colors: colors,
        ),
        NotedRichTextLinkButton(
          controller: controller,
          colors: colors,
        ),
      ],
    );
  }
}
