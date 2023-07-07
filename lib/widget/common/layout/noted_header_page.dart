import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/button/noted_icon_button.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';
import 'package:noted_app/widget/common/layout/noted_header.dart';
import 'package:noted_app/widget/common/noted_widget_config.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            NotedHeader(
              leadingAction: hasBackButton
                  ? NotedIconButton(
                      icon: NotedIcons.chevronLeft,
                      type: NotedIconButtonType.filled,
                      size: NotedWidgetSize.small,
                      // TODO: Update with routing.
                      onPressed: onBack ?? () => Navigator.of(context).pop(),
                    )
                  : null,
              title: title,
              trailingActions: trailingActions ?? [],
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
