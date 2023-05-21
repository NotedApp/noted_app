import 'package:flutter/material.dart';

class NotedLoadingIndicator extends StatelessWidget {
  final String? label;

  const NotedLoadingIndicator({this.label, super.key});

  @override
  Widget build(BuildContext context) {
    SizedBox progress = SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.tertiary,
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        labelText,
        const SizedBox(height: 16),
        progress,
      ],
    );
  }
}
