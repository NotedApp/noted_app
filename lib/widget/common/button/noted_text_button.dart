import 'package:flutter/material.dart';

enum NotedTextButtonType {
  filled,
  outlined,
  simple,
}

enum NotedTextButtonSize {
  large,
  medium,
  small,
}

class NotedTextButton extends StatelessWidget {
  final String label;
  final NotedTextButtonType type;
  final NotedTextButtonSize size;
  final IconData? icon;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const NotedTextButton({
    required this.label,
    required this.type,
    required this.size,
    this.icon,
    this.onPressed,
    this.onLongPress,
    this.foregroundColor,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case NotedTextButtonType.filled:
        return _buildFilledTextButton(context);
      case NotedTextButtonType.outlined:
        return _buildOutlinedTextButton(context);
      case NotedTextButtonType.simple:
        return _buildSimpleTextButton(context);
    }
  }

  Widget _buildFilledTextButton(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color foreground = foregroundColor ?? theme.colorScheme.onPrimary;
    Color background = backgroundColor ?? theme.colorScheme.primary;

    TextStyle? textStyle;
    EdgeInsetsGeometry padding;
    double iconSize;
    double borderRadius;

    switch (size) {
      case NotedTextButtonSize.large:
        textStyle = theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.normal);
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 13);
        iconSize = 24;
        borderRadius = 10;
        break;
      case NotedTextButtonSize.medium:
        textStyle = theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.normal);
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 10);
        iconSize = 20;
        borderRadius = 10;
        break;
      case NotedTextButtonSize.small:
        textStyle = theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.normal);
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 10);
        iconSize = 16;
        borderRadius = 8;
        break;
    }

    OutlinedBorder shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius));

    ButtonStyle style = ButtonStyle(
      textStyle: MaterialStateProperty.all(textStyle),
      backgroundColor: MaterialStateProperty.all(background),
      foregroundColor: MaterialStateProperty.all(foreground),
      elevation: MaterialStateProperty.all(3),
      padding: MaterialStateProperty.all(padding),
      iconColor: MaterialStateProperty.all(foreground),
      iconSize: MaterialStateProperty.all(iconSize),
      shape: MaterialStateProperty.all(shape),
    );

    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: style,
        icon: Icon(icon),
        label: Text(label),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: style,
        child: Text(label),
      );
    }
  }

  Widget _buildOutlinedTextButton(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color foreground = foregroundColor ?? theme.colorScheme.onBackground;

    TextStyle? textStyle;
    EdgeInsetsGeometry padding;
    double iconSize;
    double borderRadius;

    switch (size) {
      case NotedTextButtonSize.large:
        textStyle = theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.normal);
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 13);
        iconSize = 24;
        borderRadius = 10;
        break;
      case NotedTextButtonSize.medium:
        textStyle = theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.normal);
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 10);
        iconSize = 20;
        borderRadius = 10;
        break;
      case NotedTextButtonSize.small:
        textStyle = theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.normal);
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 10);
        iconSize = 16;
        borderRadius = 8;
        break;
    }

    OutlinedBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      side: BorderSide(color: foreground),
    );

    ButtonStyle style = ButtonStyle(
      textStyle: MaterialStateProperty.all(textStyle),
      foregroundColor: MaterialStateProperty.all(foreground),
      padding: MaterialStateProperty.all(padding),
      iconColor: MaterialStateProperty.all(foreground),
      iconSize: MaterialStateProperty.all(iconSize),
      shape: MaterialStateProperty.all(shape),
    );

    if (icon != null) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: style,
        icon: Icon(icon),
        label: Text(label),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: style,
        child: Text(label),
      );
    }
  }

  Widget _buildSimpleTextButton(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color foreground = foregroundColor ?? theme.colorScheme.tertiary;

    TextStyle? textStyle;
    EdgeInsetsGeometry padding;
    double iconSize;
    double borderRadius;

    switch (size) {
      case NotedTextButtonSize.large:
        textStyle = theme.textTheme.titleLarge;
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
        iconSize = 24;
        borderRadius = 10;
        break;
      case NotedTextButtonSize.medium:
        textStyle = theme.textTheme.titleMedium;
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        iconSize = 20;
        borderRadius = 10;
        break;
      case NotedTextButtonSize.small:
        textStyle = theme.textTheme.titleSmall;
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
        iconSize = 16;
        borderRadius = 8;
        break;
    }

    OutlinedBorder shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius));

    ButtonStyle style = ButtonStyle(
      textStyle: MaterialStateProperty.all(textStyle),
      foregroundColor: MaterialStateProperty.all(foreground),
      padding: MaterialStateProperty.all(padding),
      iconColor: MaterialStateProperty.all(foreground),
      iconSize: MaterialStateProperty.all(iconSize),
      shape: MaterialStateProperty.all(shape),
    );

    if (icon != null) {
      return TextButton.icon(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: style,
        icon: Icon(icon),
        label: Text(label),
      );
    } else {
      return TextButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: style,
        child: Text(label),
      );
    }
  }
}
