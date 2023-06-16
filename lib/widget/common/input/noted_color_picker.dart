import 'package:flutter/material.dart';
import 'package:noted_app/theme/custom_colors.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/noted_strings.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';
import 'package:noted_app/widget/common/layout/noted_dialog.dart';
import 'package:noted_app/widget/common/noted_widget_config.dart';

class NotedColorPicker extends StatefulWidget {
  final Color initialColor;

  const NotedColorPicker({required this.initialColor, super.key});

  @override
  State<StatefulWidget> createState() => _NotedColorPickerState();
}

class _NotedColorPickerState extends State<NotedColorPicker> {
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return NotedDialog(
      leftActionText: NotedStrings.common['confirm'],
      onLeftActionPressed: () => Navigator.of(context).pop(selectedColor),
      rightActionText: NotedStrings.common['cancel'],
      onRightActionPressed: () => Navigator.of(context).pop(),
      child: GridView.count(
        crossAxisCount: 6,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        shrinkWrap: true,
        children: customColors
            .map(
              (color) => NotedColorPickerButton(
                color: color,
                colors: colors,
                isSelected: color == selectedColor,
                onPressed: () => setState(() => selectedColor = color),
              ),
            )
            .toList(),
      ),
    );
  }
}

class NotedColorPickerButton extends StatelessWidget {
  final Color color;
  final ColorScheme colors;
  final bool isSelected;
  final VoidCallback onPressed;

  const NotedColorPickerButton({
    required this.color,
    required this.colors,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          iconColor: color.getBW().materialState(),
          overlayColor: color.getBW().withOpacity(buttonOverlayOpacity).materialState(),
          backgroundColor: color.materialState(),
          iconSize: 28.toDouble().materialState(),
          padding: EdgeInsets.zero.materialState(),
          shape: CircleBorder(side: BorderSide(color: colors.onBackground)).materialState(),
        ),
        child: isSelected ? const Center(child: Icon(NotedIcons.check)) : null,
      ),
    );
  }
}

Future<Color?> showColorPicker(BuildContext context, Color initialColor) {
  return showDialog(
    context: context,
    builder: (_) => NotedColorPicker(initialColor: initialColor),
  );
}
