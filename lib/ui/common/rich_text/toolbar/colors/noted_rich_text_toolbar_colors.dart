part of '../noted_rich_text_toolbar.dart';

// TODO: Get colors from settings bloc.
final Map<NotedRichTextAttribute, List<Color>> _colors = {
  NotedRichTextAttribute.textColor: [
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
  NotedRichTextAttribute.textBackground: [
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
    yellow200,
  ],
};

// coverage:ignore-line
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
];

class _ToolbarColorPicker extends StatefulWidget {
  final NotedRichTextController controller;
  final NotedRichTextAttribute attribute;
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

    return Row(
      children: [
        NotedIconButton(
          icon: NotedIcons.chevronLeft,
          type: NotedIconButtonType.filled,
          size: NotedWidgetSize.small,
          onPressed: () => widget.setToolbarState(_ToolbarState.home),
        ),
        SizedBox(width: 24),
        Expanded(
          child: GridView.count(
            crossAxisCount: 6,
            mainAxisSpacing: 8,
            crossAxisSpacing: 12,
            children: widget._palette
                .map(
                  (color) => NotedColorPickerButton(
                    color: color,
                    colors: colors,
                    isSelected: selectedColor == color,
                    onPressed: () => setColor(color == widget.defaultColor ? null : color),
                  ),
                )
                .toList(),
          ),
        )
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
