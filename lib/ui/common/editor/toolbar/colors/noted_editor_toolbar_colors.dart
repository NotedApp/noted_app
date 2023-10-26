part of '../noted_editor_toolbar.dart';

// TODO: Get colors from settings bloc.
final Map<NotedEditorAttribute, List<Color>> _colors = {
  NotedEditorAttribute.textColor: [
    black,
    white,
    grey400,
    grey600,
    blueGrey500,
    red500,
    indigo500,
    teal500,
    lightGreen500,
    orange500,
    brown500,
  ],
  NotedEditorAttribute.textBackground: [
    blueGrey200,
    red200,
    purple200,
    indigo200,
    lightBlue200,
    teal200,
    lightGreen200,
    yellow200,
    orange200,
    brown200,
    grey400,
  ],
};

// coverage:ignore-start
final List<Color> _defaultColors = [
  black,
  white,
  grey400,
  grey600,
  blueGrey500,
  red500,
  indigo500,
  teal500,
  lightGreen500,
  orange500,
]; // coverage:ignore-end

class _ToolbarColorPicker extends StatefulWidget {
  final NotedEditorController controller;
  final NotedEditorAttribute attribute;
  final Color defaultColor;
  final ToolbarStateCallback setToolbarState;

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
          child: GridView.count(
            crossAxisCount: 6,
            mainAxisSpacing: 8,
            crossAxisSpacing: 12,
            children: widget._palette.map(createButton).toList(),
          ),
        ),
      ],
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