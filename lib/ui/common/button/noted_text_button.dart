import 'package:flutter/material.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_app/ui/common/noted_widget_config.dart';

enum NotedTextButtonType {
  filled,
  outlined,
  simple,
}

class NotedTextButton extends StatelessWidget {
  final String? label;
  final NotedTextButtonType type;
  final NotedWidgetSize size;
  final NotedWidgetColor? color;
  final IconData? icon;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Color? foregroundColor;
  final Color? backgroundColor;

  /// Create a new noted text button.
  ///
  /// [type] defines the style of button.
  ///  - The type dictates how the button colors are applied.
  ///
  /// [size] defines the size of the button.
  ///  - The size differs depending on the type of button.
  ///
  /// [color] defines te color scheme of the button.
  ///  - The default differs depending on the type of button.
  ///  - The colors can be override with [foregroundColor] and [backgroundColor].
  const NotedTextButton({
    required this.label,
    required this.type,
    this.size = NotedWidgetSize.medium,
    this.color,
    this.icon,
    required this.onPressed,
    this.onLongPress,
    this.foregroundColor,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    _NotedTextButtonBuilder builder = switch (type) {
      NotedTextButtonType.filled => _FilledTextButtonBuilder(this),
      NotedTextButtonType.outlined => _OutlinedTextButtonBuilder(this),
      NotedTextButtonType.simple => _SimpleTextButtonBuilder(this),
    };

    ButtonStyle style = builder.styleOf(theme.colorScheme, theme.textTheme).copyWith(
          foregroundColor: foregroundColor?.widgetState(),
          backgroundColor: backgroundColor?.widgetState(),
          overlayColor: foregroundColor?.withOpacity(NotedWidgetConfig.buttonOverlayOpacity).widgetState(),
          iconColor: foregroundColor?.widgetState(),
        );

    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: style,
        icon: Icon(icon),
        label: Text(label ?? ''),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: style,
        child: Text(label ?? ''),
      );
    }
  }
}

abstract class _NotedTextButtonBuilder {
  final NotedTextButton source;

  const _NotedTextButtonBuilder(this.source);

  ButtonStyle styleOf(ColorScheme colors, TextTheme fonts);
}

class _FilledTextButtonBuilder extends _NotedTextButtonBuilder {
  const _FilledTextButtonBuilder(super.source);

  @override
  ButtonStyle styleOf(ColorScheme colors, TextTheme fonts) {
    (Color, Color) buttonColors = switch (source.color) {
      NotedWidgetColor.primary => (colors.onPrimary, colors.primary),
      NotedWidgetColor.secondary => (colors.onSecondary, colors.secondary),
      NotedWidgetColor.tertiary => (colors.onTertiary, colors.tertiary),
      _ => (colors.onPrimary, colors.primary),
    };

    TextStyle? textStyle;
    EdgeInsets padding;
    double iconSize;
    double borderRadius;

    switch (source.size) {
      case NotedWidgetSize.large:
        textStyle = fonts.titleLarge?.copyWith(fontWeight: FontWeight.normal);
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 13);
        iconSize = 24;
        borderRadius = 10;
      case NotedWidgetSize.medium:
        textStyle = fonts.titleMedium?.copyWith(fontWeight: FontWeight.normal);
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 10);
        iconSize = 20;
        borderRadius = 10;
      case NotedWidgetSize.small:
        textStyle = fonts.titleSmall?.copyWith(fontWeight: FontWeight.normal);
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 10);
        iconSize = 16;
        borderRadius = 8;
    }

    OutlinedBorder shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius));

    return ButtonStyle(
      textStyle: textStyle?.widgetState(),
      backgroundColor: buttonColors.$2.widgetState(),
      foregroundColor: buttonColors.$1.widgetState(),
      overlayColor: buttonColors.$1.withOpacity(NotedWidgetConfig.buttonOverlayOpacity).widgetState(),
      elevation: 3.toDouble().widgetState(),
      padding: padding.widgetState(),
      iconColor: buttonColors.$1.widgetState(),
      iconSize: iconSize.widgetState(),
      shape: shape.widgetState(),
    );
  }
}

class _OutlinedTextButtonBuilder extends _NotedTextButtonBuilder {
  const _OutlinedTextButtonBuilder(super.source);

  @override
  ButtonStyle styleOf(ColorScheme colors, TextTheme fonts) {
    (Color, Color) buttonColors = switch (source.color) {
      NotedWidgetColor.primary => (colors.primary, Colors.transparent),
      NotedWidgetColor.secondary => (colors.secondary, Colors.transparent),
      NotedWidgetColor.tertiary => (colors.tertiary, Colors.transparent),
      _ => (colors.onSurface, Colors.transparent),
    };

    TextStyle? textStyle;
    EdgeInsets padding;
    double iconSize;
    double borderRadius;

    switch (source.size) {
      case NotedWidgetSize.large:
        textStyle = fonts.titleLarge?.copyWith(fontWeight: FontWeight.normal);
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 13);
        iconSize = 24;
        borderRadius = 10;
      case NotedWidgetSize.medium:
        textStyle = fonts.titleMedium?.copyWith(fontWeight: FontWeight.normal);
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 10);
        iconSize = 20;
        borderRadius = 10;
      case NotedWidgetSize.small:
        textStyle = fonts.titleSmall?.copyWith(fontWeight: FontWeight.normal);
        padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 10);
        iconSize = 16;
        borderRadius = 8;
    }

    OutlinedBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      side: BorderSide(color: buttonColors.$1),
    );

    return ButtonStyle(
      textStyle: textStyle?.widgetState(),
      foregroundColor: buttonColors.$1.widgetState(),
      backgroundColor: buttonColors.$2.widgetState(),
      overlayColor: buttonColors.$1.withOpacity(NotedWidgetConfig.buttonOverlayOpacity).widgetState(),
      elevation: 0.toDouble().widgetState(),
      padding: padding.widgetState(),
      iconColor: buttonColors.$1.widgetState(),
      iconSize: iconSize.widgetState(),
      shape: shape.widgetState(),
    );
  }
}

class _SimpleTextButtonBuilder extends _NotedTextButtonBuilder {
  const _SimpleTextButtonBuilder(super.source);

  @override
  ButtonStyle styleOf(ColorScheme colors, TextTheme fonts) {
    (Color, Color) buttonColors = switch (source.color) {
      NotedWidgetColor.primary => (colors.primary, Colors.transparent),
      NotedWidgetColor.secondary => (colors.secondary, Colors.transparent),
      NotedWidgetColor.tertiary => (colors.tertiary, Colors.transparent),
      _ => (colors.onSurface, Colors.transparent),
    };

    TextStyle? textStyle;
    EdgeInsets padding;
    double iconSize;
    double borderRadius;

    switch (source.size) {
      case NotedWidgetSize.large:
        textStyle = fonts.titleLarge;
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
        iconSize = 24;
        borderRadius = 10;
      case NotedWidgetSize.medium:
        textStyle = fonts.titleMedium;
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        iconSize = 20;
        borderRadius = 10;
      case NotedWidgetSize.small:
        textStyle = fonts.titleSmall;
        padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
        iconSize = 16;
        borderRadius = 8;
    }

    OutlinedBorder shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius));

    return ButtonStyle(
      textStyle: textStyle?.widgetState(),
      foregroundColor: buttonColors.$1.widgetState(),
      backgroundColor: buttonColors.$2.widgetState(),
      overlayColor: buttonColors.$1.withOpacity(NotedWidgetConfig.buttonOverlayOpacity).widgetState(),
      elevation: 0.toDouble().widgetState(),
      padding: padding.widgetState(),
      iconColor: buttonColors.$1.widgetState(),
      iconSize: iconSize.widgetState(),
      shape: shape.widgetState(),
    );
  }
}
