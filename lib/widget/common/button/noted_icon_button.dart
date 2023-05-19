import 'package:flutter/material.dart';

enum NotedIconButtonType {
  filled,
  simple,
}

enum NotedIconButtonSize {
  large,
  medium,
  small,
}

class NotedIconButton extends StatelessWidget {
  final IconData icon;
  final NotedIconButtonType type;
  final NotedIconButtonSize size;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool hasOutline;

  const NotedIconButton({
    required this.icon,
    required this.type,
    required this.size,
    this.onPressed,
    this.onLongPress,
    this.iconColor,
    this.backgroundColor,
    this.hasOutline = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case NotedIconButtonType.filled:
        return _buildFilledIconButton(context);
      case NotedIconButtonType.simple:
        return _buildSimpleIconButton(context);
    }
  }

  Widget _buildFilledIconButton(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color foreground = iconColor ?? colorScheme.onPrimary;
    Color background = backgroundColor ?? colorScheme.primary;

    double iconSize;
    double circleSize;

    switch (size) {
      case NotedIconButtonSize.large:
        iconSize = 36;
        circleSize = 64;
        break;
      case NotedIconButtonSize.medium:
        iconSize = 30;
        circleSize = 54;
        break;
      case NotedIconButtonSize.small:
        iconSize = 24;
        circleSize = 44;
        break;
    }

    OutlinedBorder shape = CircleBorder(side: hasOutline ? BorderSide(color: foreground) : BorderSide.none);

    ButtonStyle style = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(background),
      foregroundColor: MaterialStateProperty.all(foreground),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      elevation: MaterialStateProperty.all(3),
      fixedSize: MaterialStateProperty.all(Size.square(circleSize)),
      iconColor: MaterialStateProperty.all(foreground),
      iconSize: MaterialStateProperty.all(iconSize),
      shape: MaterialStateProperty.all(shape),
    );

    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      child: Center(child: Icon(icon)),
    );
  }

  Widget _buildSimpleIconButton(BuildContext context) {
    Color foreground = iconColor ?? Theme.of(context).colorScheme.onPrimary;

    double iconSize;
    double circleSize;

    switch (size) {
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

    OutlinedBorder shape = CircleBorder(side: hasOutline ? BorderSide(color: foreground) : BorderSide.none);

    ButtonStyle style = ButtonStyle(
      foregroundColor: MaterialStateProperty.all(foreground),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      fixedSize: MaterialStateProperty.all(Size.square(circleSize)),
      iconColor: MaterialStateProperty.all(foreground),
      iconSize: MaterialStateProperty.all(iconSize),
      shape: MaterialStateProperty.all(shape),
    );

    return TextButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      child: Center(child: Icon(icon)),
    );
  }
}
