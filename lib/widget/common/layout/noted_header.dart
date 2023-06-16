import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/button/noted_icon_button.dart';

class NotedHeader extends StatelessWidget {
  final NotedIconButton? leadingAction;
  final String? title;
  final List<NotedIconButton> trailingActions;

  const NotedHeader({
    this.leadingAction,
    this.title,
    this.trailingActions = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (leadingAction != null) {
      children.add(leadingAction!);
      children.add(const SizedBox(width: 16));
    }

    if (title?.isNotEmpty ?? false) {
      children.add(
        Expanded(
          child: Text(
            title!,
            style: Theme.of(context).textTheme.displayMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    } else {
      children.add(const Spacer());
    }

    for (NotedIconButton action in trailingActions) {
      children.add(const SizedBox(width: 12));
      children.add(action);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      width: double.infinity,
      height: 52,
      child: Row(children: children),
    );
  }
}
