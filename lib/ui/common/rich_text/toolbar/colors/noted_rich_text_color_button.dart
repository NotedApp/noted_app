import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';

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
    return NotedIconButton(
      icon: isSelected ? NotedIcons.check : null,
      type: NotedIconButtonType.filled,
      onPressed: onPressed,
      iconColor: color.getBW(),
      backgroundColor: color,
      outlineColor: colors.onBackground,
    );
  }
}
