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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      width: double.infinity,
      height: 52,
      child: Row(
        children: [
          if (leadingAction != null) Padding(padding: EdgeInsets.only(right: 16), child: leadingAction),
          if (title?.isNotEmpty ?? false)
            Expanded(
              child: Text(
                title!,
                style: Theme.of(context).textTheme.displayMedium,
                overflow: TextOverflow.ellipsis,
              ),
            )
          else
            const Spacer(),
          for (NotedIconButton action in trailingActions) Padding(padding: EdgeInsets.only(left: 12), child: action),
        ],
      ),
    );
  }
}
