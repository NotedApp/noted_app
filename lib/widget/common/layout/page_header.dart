import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/button/noted_icon_button.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final bool showButton;
  final Function()? onButtonPressed;
  final IconData buttonIcon;

  const PageHeader({
    required this.title,
    this.showButton = false,
    this.onButtonPressed,
    this.buttonIcon = NotedIcons.chevronLeft,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [Text(title, style: Theme.of(context).textTheme.displayMedium)];

    if (showButton) {
      children.insert(
        0,
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: NotedIconButton(
            icon: buttonIcon,
            type: NotedIconButtonType.filled,
            size: NotedIconButtonSize.small,
            onPressed: onButtonPressed,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      width: double.infinity,
      height: 52,
      child: Row(children: children),
    );
  }
}
