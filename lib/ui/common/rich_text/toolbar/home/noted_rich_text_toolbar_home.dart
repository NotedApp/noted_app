part of '../noted_rich_text_toolbar.dart';

class _ToolbarHome extends StatelessWidget {
  final NotedRichTextController controller;
  final ToolbarStateCallback setToolbarState;

  const _ToolbarHome({required this.controller, required this.setToolbarState, super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return GridView.count(
      crossAxisCount: 7,
      mainAxisSpacing: 8,
      crossAxisSpacing: 12,
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
        NotedRichTextStateButton(
          controller: controller,
          attribute: NotedRichTextAttribute.textColor,
          colors: colors,
          onPressed: () => setToolbarState(_ToolbarState.textColor),
        ),
        NotedRichTextStateButton(
          controller: controller,
          attribute: NotedRichTextAttribute.textBackground,
          colors: colors,
          onPressed: () => setToolbarState(_ToolbarState.highlightColor),
        ),
        NotedRichTextStateButton(
          controller: controller,
          attribute: NotedRichTextAttribute.link,
          colors: colors,
          onPressed: () => setToolbarState(_ToolbarState.link),
        ),
      ],
    );
  }
}
