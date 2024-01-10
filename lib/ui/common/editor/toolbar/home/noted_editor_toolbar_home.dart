part of '../noted_editor_toolbar.dart';

class _ToolbarHome extends StatelessWidget {
  final NotedEditorController controller;
  final _ToolbarStateCallback setToolbarState;

  const _ToolbarHome({required this.controller, required this.setToolbarState, super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return GridView.count(
      padding: _toolbarPadding,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      mainAxisSpacing: 8,
      crossAxisSpacing: 12,
      children: [
        NotedEditorToggleButton(
          controller: controller,
          attribute: NotedEditorAttribute.bold,
          colors: colors,
        ),
        NotedEditorToggleButton(
          controller: controller,
          attribute: NotedEditorAttribute.italic,
          colors: colors,
        ),
        NotedEditorToggleButton(
          controller: controller,
          attribute: NotedEditorAttribute.underline,
          colors: colors,
        ),
        NotedEditorToggleButton(
          controller: controller,
          attribute: NotedEditorAttribute.strikethrough,
          colors: colors,
        ),
        NotedEditorToggleButton(
          controller: controller,
          attribute: NotedEditorAttribute.h1,
          colors: colors,
        ),
        NotedEditorToggleButton(
          controller: controller,
          attribute: NotedEditorAttribute.h2,
          colors: colors,
        ),
        NotedEditorToggleButton(
          controller: controller,
          attribute: NotedEditorAttribute.h3,
          colors: colors,
        ),
        NotedEditorToggleButton(
          controller: controller,
          attribute: NotedEditorAttribute.ul,
          colors: colors,
        ),
        NotedEditorToggleButton(
          controller: controller,
          attribute: NotedEditorAttribute.ol,
          colors: colors,
        ),
        NotedEditorToggleButton(
          controller: controller,
          attribute: NotedEditorAttribute.taskList,
          colors: colors,
        ),
        NotedEditorStateButton(
          controller: controller,
          attribute: NotedEditorAttribute.textColor,
          colors: colors,
          onPressed: () => setToolbarState(_ToolbarState.textColor),
        ),
        NotedEditorStateButton(
          controller: controller,
          attribute: NotedEditorAttribute.textBackground,
          colors: colors,
          onPressed: () => setToolbarState(_ToolbarState.highlightColor),
        ),
        NotedEditorStateButton(
          controller: controller,
          attribute: NotedEditorAttribute.link,
          colors: colors,
          onPressed: () => setToolbarState(_ToolbarState.link),
        ),
      ],
    );
  }
}
