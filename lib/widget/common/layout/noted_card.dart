import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/noted_widget_config.dart';

class NotedCard extends StatelessWidget {
  final NotedWidgetSize size;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final VoidCallback? onTap;
  final Widget? child;

  const NotedCard({
    required this.size,
    this.width,
    this.height,
    this.margin,
    this.color,
    this.onTap,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    double borderRadius = switch (size) {
      NotedWidgetSize.large => 24,
      NotedWidgetSize.medium => 16,
      NotedWidgetSize.small => 12,
    };

    ShapeBorder shape = RoundedRectangleBorder(
      side: BorderSide(color: colors.onBackground, width: 2),
      borderRadius: BorderRadius.circular(borderRadius),
    );

    return SizedBox(
      width: width,
      height: height,
      child: Card(
        color: color ?? colors.background,
        elevation: 4,
        shape: shape,
        margin: margin,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: child,
        ),
      ),
    );
  }
}
