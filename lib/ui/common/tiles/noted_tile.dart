import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/layout/noted_card.dart';
import 'package:noted_app/ui/common/noted_widget_config.dart';
import 'package:noted_app/util/extensions.dart';

class NotedTile extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const NotedTile({required this.child, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return NotedCard(
      size: NotedWidgetSize.small,
      color: context.colorScheme().background,
      onTap: onTap,
      child: child,
    );
  }
}
