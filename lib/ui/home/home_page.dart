import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/ui/router/noted_router.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotedHeaderPage(
      hasBackButton: false,
      child: Center(child: Text('hello world')),
      title: context.strings().app_title,
      trailingActions: [
        NotedIconButton(
          icon: NotedIcons.settings,
          type: NotedIconButtonType.filled,
          size: NotedWidgetSize.small,
          onPressed: () => context.push('/settings'),
        ),
      ],
    );
  }
}
