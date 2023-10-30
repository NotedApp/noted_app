import 'package:flutter/material.dart';

class NotedLoadingIndicator extends StatelessWidget {
  final String? label;
  final double size;
  final Color? color;

  const NotedLoadingIndicator({this.label, this.size = 24, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    SizedBox progress = SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color ?? theme.colorScheme.tertiary,
        strokeWidth: 2,
        semanticsLabel: label,
      ),
    );

    if (label == null) {
      return progress;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label!,
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        progress,
      ],
    );
  }
}
