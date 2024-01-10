part of '../noted_editor_toolbar.dart';

// TODO: Get colors from style settings bloc.
final Map<NotedEditorAttribute, List<Color>> _colors = {
  NotedEditorAttribute.textColor: [
    Colors.black,
    Colors.white,
    Colors.grey.shade400,
    Colors.grey.shade600,
    Colors.blueGrey.shade500,
    Colors.red.shade500,
    Colors.indigo.shade500,
    Colors.teal.shade500,
    Colors.lightGreen.shade500,
    Colors.orange.shade500,
    Colors.brown.shade500,
  ],
  NotedEditorAttribute.textBackground: [
    Colors.blueGrey.shade200,
    Colors.red.shade200,
    Colors.purple.shade200,
    Colors.indigo.shade200,
    Colors.lightBlue.shade200,
    Colors.teal.shade200,
    Colors.lightGreen.shade200,
    Colors.yellow.shade200,
    Colors.orange.shade200,
    Colors.brown.shade200,
    Colors.grey.shade400,
  ],
};

// coverage:ignore-start
final List<Color> _defaultColors = [
  Colors.black,
  Colors.white,
  Colors.grey.shade400,
  Colors.grey.shade600,
  Colors.blueGrey.shade500,
  Colors.red.shade500,
  Colors.indigo.shade500,
  Colors.teal.shade500,
  Colors.lightGreen.shade500,
  Colors.orange.shade500,
  Colors.brown.shade500,
]; // coverage:ignore-end

class _ToolbarColorPicker extends StatefulWidget {
  final NotedEditorController controller;
  final NotedEditorAttribute attribute;
  final Color defaultColor;
  final _ToolbarStateCallback setToolbarState;

  const _ToolbarColorPicker({
    required this.controller,
    required this.attribute,
    required this.defaultColor,
    required this.setToolbarState,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ToolbarColorPickerState();

  Color get _currentColor => controller.getColor(attribute) ?? defaultColor;

  List<Color> get _palette => [defaultColor, ..._colors[attribute] ?? _defaultColors];
}

class _ToolbarColorPickerState extends State<_ToolbarColorPicker> {
  late Color selectedColor;

  void setCurrentColor() {
    setState(() => selectedColor = widget._currentColor);
  }

  @override
  void initState() {
    selectedColor = widget._currentColor;
    widget.controller.addListener(setCurrentColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = context.colorScheme();

    Widget createButton(Color color) {
      return NotedColorPickerButton(
        color: color,
        colors: colors,
        isSelected: selectedColor == color,
        onPressed: () => setColor(color == widget.defaultColor ? null : color),
      );
    }

    return Padding(
      padding: _toolbarPadding,
      child: Row(
        children: [
          NotedIconButton(
            icon: NotedIcons.chevronLeft,
            type: NotedIconButtonType.filled,
            size: NotedWidgetSize.small,
            color: NotedWidgetColor.tertiary,
            onPressed: () => widget.setToolbarState(_ToolbarState.home),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 6,
              mainAxisSpacing: 8,
              crossAxisSpacing: 12,
              children: widget._palette.map(createButton).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(setCurrentColor);
    super.dispose();
  }

  void setColor(Color? color) {
    widget.controller.setColor(widget.attribute, color);
  }
}
