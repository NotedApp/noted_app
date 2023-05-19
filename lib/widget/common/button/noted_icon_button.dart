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
  final Function()? onPressed;
  final IconData icon;
  final NotedIconButtonType type;
  final NotedIconButtonSize size;
  final Color? iconColor;
  final Color? backgroundColor;
  final double strokeWidth;

  const NotedIconButton(
    this.onPressed,
    this.icon, {
    this.type = NotedIconButtonType.standard,
    this.size = NotedIconButtonSize.medium,
    this.iconColor,
    this.backgroundColor,
    this.strokeWidth = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case NotedIconButtonType.filled:
        return _buildFilledIconButton(context);
      case NotedIconButtonType.standard:
        return _buildStandardIconButton(context);
    }
  }

  Widget _buildFilledIconButton(BuildContext context) {
    Color background = backgroundColor ?? Theme.of(context).colorScheme.primary;
    Color foreground = iconColor ?? Theme.of(context).colorScheme.onPrimary;
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

    ShapeBorder border = strokeWidth > 0
        ? CircleBorder(
            side: BorderSide(
              color: foreground,
              width: strokeWidth,
            ),
          )
        : const CircleBorder();

    return SizedBox(
      width: circleSize,
      height: circleSize,
      child: FloatingActionButton(
        onPressed: onPressed,
        foregroundColor: foreground,
        backgroundColor: background,
        elevation: 3,
        shape: border,
        child: Icon(icon, size: iconSize),
      ),
    );
  }

  Widget _buildStandardIconButton(BuildContext context) {
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

    OutlinedBorder border =
        strokeWidth > 0 ? CircleBorder(side: BorderSide(color: foreground, width: strokeWidth)) : const CircleBorder();

    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      padding: EdgeInsets.all((circleSize - iconSize) / 2),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(Size(circleSize, circleSize)),
        iconSize: MaterialStateProperty.all<double>(iconSize),
        foregroundColor: MaterialStateProperty.all<Color>(foreground),
        iconColor: MaterialStateProperty.all<Color>(foreground),
        elevation: MaterialStateProperty.all<double>(1),
        shape: MaterialStateProperty.all<OutlinedBorder>(border),
      ),
    );
  }
}
