import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_widget_config.dart';

class NotedCard extends StatelessWidget {
  final NotedWidgetSize size;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Widget? child;

  const NotedCard({
    required this.size,
    this.margin,
    this.color,
    this.borderColor,
    this.onPressed,
    this.onLongPressed,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    BorderRadius borderRadius = BorderRadius.circular(
      switch (size) {
        NotedWidgetSize.large => 24,
        NotedWidgetSize.medium => 16,
        NotedWidgetSize.small => 12,
      },
    );

    ShapeBorder shape = RoundedRectangleBorder(
      side: BorderSide(color: borderColor ?? colors.onBackground),
      borderRadius: borderRadius,
    );

    Widget? contents = onPressed == null
        ? child
        : InkWell(
            onTap: onPressed,
            onLongPress: onLongPressed,
            borderRadius: borderRadius,
            child: child,
          );

    return Card(
      color: color ?? colors.background,
      elevation: 4,
      shape: shape,
      margin: margin,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: contents,
      ),
    );
  }
}
