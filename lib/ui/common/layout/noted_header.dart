import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';

class NotedHeader extends AppBar {
  NotedHeader({
    required BuildContext context,
    Widget? leadingAction,
    String? title,
    List<NotedIconButton> trailingActions = const [],
    super.bottom,
    super.backgroundColor,
    super.key,
  }) : super(
          toolbarHeight: Dimens.size_64,
          automaticallyImplyLeading: false,
          leadingWidth: Dimens.size_64,
          leading: _getLeading(leadingAction),
          title: _getTitle(title, context),
          actions: [
            ...trailingActions.map(_getAction),
            const SizedBox(width: Dimens.spacing_xs),
          ],
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

  return Text(title, style: Theme.of(context).textTheme.displaySmall);
}

Widget _getAction(NotedIconButton action) {
  return Padding(padding: const EdgeInsets.only(right: Dimens.spacing_m), child: action);
}
