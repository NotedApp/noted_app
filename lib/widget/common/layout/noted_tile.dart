import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/layout/noted_card.dart';
import 'package:noted_app/widget/common/noted_widget_config.dart';

class NotedTile extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const NotedTile({required this.child, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: NotedCard(
        size: NotedWidgetSize.small,
        color: Theme.of(context).colorScheme.surface,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
