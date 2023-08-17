import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/button/noted_icon_button.dart';
import 'package:noted_app/ui/common/icon/noted_icons.dart';
import 'package:noted_app/ui/common/layout/noted_header.dart';
import 'package:noted_app/ui/common/noted_widget_config.dart';
import 'package:noted_app/ui/router/noted_router.dart';

class NotedHeaderPage extends StatelessWidget {
  final Widget child;
  final bool hasBackButton;
  final VoidCallback? onBack;
  final String? title;
  final List<NotedIconButton>? trailingActions;

  const NotedHeaderPage({
    required this.child,
    required this.hasBackButton,
    this.onBack,
    this.title,
    this.trailingActions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotedHeader(
        context: context,
        leadingAction: hasBackButton
            ? NotedIconButton(
                icon: NotedIcons.chevronLeft,
                type: NotedIconButtonType.filled,
                size: NotedWidgetSize.small,
                onPressed: onBack ?? () => context.pop(),
              )
            : null,
        title: title,
        trailingActions: trailingActions ?? [],
      ),
      body: child,
    );
  }
}
