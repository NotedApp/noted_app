import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/button/noted_icon_button.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';

class PageHeader extends StatelessWidget {
  final String _title;
  final bool _showButton;
  final Function()? _onButtonPressed;
  final IconData _buttonIcon;

  const PageHeader(
    this._title,
    this._showButton, {
    Function()? onButtonPressed,
    IconData buttonIcon = NotedIcons.chevronLeft,
    super.key,
  })  : _onButtonPressed = onButtonPressed,
        _buttonIcon = buttonIcon;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [Text(_title, style: Theme.of(context).textTheme.displayMedium)];

    if (_showButton) {
      children.insert(
        0,
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: NotedIconButton(
            _onButtonPressed,
            _buttonIcon,
            type: NotedIconButtonType.filled,
            size: NotedIconButtonSize.small,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      width: double.infinity,
      height: 52,
      child: Row(
        children: children,
      ),
    );
  }
}
