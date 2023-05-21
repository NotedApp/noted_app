import 'package:flutter/material.dart';

enum NotedCardSize {
  large,
  medium,
  small,
}

class NotedCard extends StatelessWidget {
  final NotedCardSize size;
  final double? width;
  final double? height;
  final Widget? child;

  const NotedCard({required this.size, this.width, this.height, this.child, super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    double borderRadius = switch (size) {
      NotedCardSize.large => 24,
      NotedCardSize.medium => 16,
      NotedCardSize.small => 12,
    };

    ShapeBorder shape = RoundedRectangleBorder(
      side: BorderSide(color: colors.onBackground, width: 2),
      borderRadius: BorderRadius.circular(borderRadius),
    );

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      child: Card(
        color: colors.surface,
        elevation: 4,
        shape: shape,
        borderOnForeground: true,
        child: child,
      ),
    );
  }
}
