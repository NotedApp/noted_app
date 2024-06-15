import 'package:flutter/material.dart';
import 'package:noted_app/util/extensions/extensions.dart';

class StrokedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? strokeColor;
  final double strokeWidth;

  const StrokedText(
    this.text, {
    this.style,
    this.strokeColor,
    this.strokeWidth = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = strokeColor ?? context.colorScheme().onSurface;

    return Stack(
      children: [
        Text(text, style: style?.copyWith(foreground: paint) ?? TextStyle(foreground: paint)),
        Text(text, style: style),
      ],
    );
  }
}
