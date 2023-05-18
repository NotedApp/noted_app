import 'package:flutter/material.dart';

enum NotedIconButtonType {
  filled,
  standard,
}

enum NotedIconButtonSize {
  large,
  medium,
  small,
}

class NotedIconButton extends StatelessWidget {
  final Function() _onPressed;
  final IconData _icon;
  final NotedIconButtonType _type;
  final NotedIconButtonSize _size;
  final Color? _iconColor;
  final Color? _backgroundColor;
  final double _strokeWidth;

  const NotedIconButton(
    this._onPressed,
    this._icon, {
    NotedIconButtonType type = NotedIconButtonType.standard,
    NotedIconButtonSize size = NotedIconButtonSize.medium,
    Color? iconColor,
    Color? backgroundColor,
    double strokeWidth = 0,
    super.key,
  })  : _type = type,
        _size = size,
        _iconColor = iconColor,
        _backgroundColor = backgroundColor,
        _strokeWidth = strokeWidth;

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case NotedIconButtonType.filled:
        return _buildFilledIconButton(context);
      case NotedIconButtonType.standard:
        return _buildStandardIconButton(context);
    }
  }

  Widget _buildFilledIconButton(BuildContext context) {
    Color background = _backgroundColor ?? Theme.of(context).colorScheme.primary;
    Color foreground = _iconColor ?? Theme.of(context).colorScheme.onPrimary;
    double iconSize;
    double circleSize;

    switch (_size) {
      case NotedIconButtonSize.large:
        iconSize = 36;
        circleSize = 64;
        break;
      case NotedIconButtonSize.medium:
        iconSize = 30;
        circleSize = 54;
        break;
      case NotedIconButtonSize.small:
        iconSize = 22;
        circleSize = 40;
        break;
    }

    return IconButton.filled(
      onPressed: _onPressed,
      icon: Icon(_icon),
      padding: EdgeInsets.all((circleSize - iconSize) / 2),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(Size(circleSize, circleSize)),
        iconSize: MaterialStateProperty.all<double>(iconSize),
        backgroundColor: MaterialStateProperty.all<Color>(background),
        foregroundColor: MaterialStateProperty.all<Color>(foreground),
        iconColor: MaterialStateProperty.all<Color>(foreground),
        elevation: MaterialStateProperty.all<double>(1),
      ),
    );
  }

  Widget _buildStandardIconButton(BuildContext context) {
    Color foreground = _iconColor ?? Theme.of(context).colorScheme.onPrimary;
    double iconSize;
    double circleSize;

    switch (_size) {
      case NotedIconButtonSize.large:
        iconSize = 36;
        circleSize = 54;
        break;
      case NotedIconButtonSize.medium:
        iconSize = 30;
        circleSize = 44;
        break;
      case NotedIconButtonSize.small:
        iconSize = 22;
        circleSize = 36;
        break;
    }

    return IconButton(
      onPressed: _onPressed,
      icon: Icon(_icon),
      padding: EdgeInsets.all((circleSize - iconSize) / 2),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(Size(circleSize, circleSize)),
        iconSize: MaterialStateProperty.all<double>(iconSize),
        foregroundColor: MaterialStateProperty.all<Color>(foreground),
        iconColor: MaterialStateProperty.all<Color>(foreground),
        elevation: MaterialStateProperty.all<double>(1),
      ),
    );
  }
}
