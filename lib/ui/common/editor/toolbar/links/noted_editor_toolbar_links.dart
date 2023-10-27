part of '../noted_editor_toolbar.dart';

class _ToolbarLinkPicker extends StatefulWidget {
  final NotedEditorController controller;
  final ToolbarStateCallback setToolbarState;

  const _ToolbarLinkPicker({
    required this.controller,
    required this.setToolbarState,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ToolbarLinkPickerState();

  String get _currentLink => controller.getLink() ?? '';
}

class _ToolbarLinkPickerState extends State<_ToolbarLinkPicker> {
  final TextEditingController textController = TextEditingController();

  void setCurrentLink() {
    textController.text = widget._currentLink;
  }

  @override
  void initState() {
    setCurrentLink();
    widget.controller.addListener(setCurrentLink);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NotedIconButton(
          icon: NotedIcons.chevronLeft,
          type: NotedIconButtonType.filled,
          size: NotedWidgetSize.small,
          color: NotedWidgetColor.tertiary,
          onPressed: () => widget.setToolbarState(_ToolbarState.home),
        ),
        SizedBox(width: 16),
        Expanded(
          child: NotedTextField(
            type: NotedTextFieldType.standard,
            name: context.strings().editor_linkPickerTitle,
            controller: textController,
            onSubmitted: (value) => widget.controller.setLink(value),
          ),
        ),
        SizedBox(width: 8),
      ],
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(setCurrentLink);
    textController.dispose();
    super.dispose();
  }
}
