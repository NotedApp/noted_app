import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/button/noted_icon_button.dart';

class NotedHeader extends AppBar {
  NotedHeader({
    required BuildContext context,
    Widget? leadingAction,
    String? title,
    List<NotedIconButton> trailingActions = const [],
    super.bottom,
    super.key,
  }) : super(
          toolbarHeight: 72,
          automaticallyImplyLeading: false,
          leadingWidth: 60,
          leading: _getLeading(leadingAction),
          title: _getTitle(title, context),
          actions: [
            ...trailingActions.map(_getAction),
            const SizedBox(width: 4),
          ],
          forceMaterialTransparency: true,
        );
}

Widget? _getLeading(Widget? leading) {
  if (leading == null) {
    return null;
  }

  return Align(alignment: Alignment.centerRight, child: leading);
}

Widget? _getTitle(String? title, BuildContext context) {
  if (title == null) {
    return null;
  }

  return Text(title, style: Theme.of(context).textTheme.displayMedium);
}

Widget _getAction(NotedIconButton action) {
  return Padding(padding: const EdgeInsets.only(right: 12), child: action);
}
