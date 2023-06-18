import 'package:flutter/material.dart';

class NotedLoadingIndicator extends StatelessWidget {
  final String? label;

  const NotedLoadingIndicator({this.label, super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    SizedBox progress = SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        color: theme.colorScheme.tertiary,
        strokeWidth: 2,
        semanticsLabel: label,
      ),
    );

    if (label == null) {
      return progress;
    }

    Text labelText = Text(
      label!,
      style: Theme.of(context).textTheme.bodyMedium,
    );

    return Column(
      children: [
        labelText,
        const SizedBox(height: 16),
        progress,
      ],
    );
  }
}
