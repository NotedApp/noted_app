import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/noted_widget_config.dart';

enum NotedIconButtonType {
  simple,
  filled,
}

class NotedIconButton extends StatelessWidget {
  final IconData icon;
  final NotedIconButtonType type;
  final NotedWidgetSize size;
  final NotedWidgetColor? color;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? outlineColor;

  /// Create a new noted icon button.
  ///
  /// [type] defines the style of button.
  ///  - [NotedIconButtonType.simple] results in a plain icon button with no background.
  ///  - [NotedIconButtonType.filled] results in a filled icon button with a colored background.
  ///
  /// [size] defines the size of button.
  ///  - The size differs depending on the type of button.
  ///
  /// [color] defines the color scheme of the butten.
  ///  - The default differs depending on the type of button.
  const NotedIconButton({
    required this.type,
    this.size = NotedWidgetSize.medium,
    this.color,
    required this.icon,
    required this.onPressed,
    this.onLongPress,
    this.iconColor,
    this.backgroundColor,
    this.outlineColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    _NotedIconButtonBuilder builder = switch (type) {
      NotedIconButtonType.simple => _SimpleIconButtonBuilder(this),
      NotedIconButtonType.filled => _FilledIconButtonBuilder(this),
    };

    Color foreground;
    Color background;
    double iconSize;
    double widgetSize;
    double elevation;

    (foreground, background) = builder.colorsOf(colorScheme);
    (iconSize, widgetSize) = builder.sizeOf();
    elevation = builder.elevation();

    OutlinedBorder shape = CircleBorder(
      side: outlineColor != null ? BorderSide(color: outlineColor!) : BorderSide.none,
    );

    ButtonStyle style = ButtonStyle(
      iconColor: MaterialStatePropertyAll(iconColor ?? foreground),
      backgroundColor: MaterialStatePropertyAll(backgroundColor ?? background),
      overlayColor: MaterialStatePropertyAll((iconColor ?? foreground).withOpacity(0.1)),
      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
      elevation: MaterialStatePropertyAll(elevation),
      minimumSize: const MaterialStatePropertyAll(Size.zero),
      fixedSize: MaterialStatePropertyAll(Size.square(widgetSize)),
      iconSize: MaterialStatePropertyAll(iconSize),
      shape: MaterialStatePropertyAll(shape),
    );

    return SizedBox(
      width: widgetSize,
      height: widgetSize,
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: style,
        child: Icon(icon), // Center(child: Icon(icon)),
      ),
    );
  }
}

/// Provides a set of methods to define the appearance of a certain type of icon button.
abstract class _NotedIconButtonBuilder {
  final NotedIconButton source;

  const _NotedIconButtonBuilder(this.source);

  /// Return a record containing the icon color and background color of the icon button.
  (Color, Color) colorsOf(ColorScheme colors);

  /// Return a record containing the icon size and widget size of the icon button.
  (double, double) sizeOf();

  /// Return the elevation associated with the icon button.
  double elevation();
}

class _SimpleIconButtonBuilder extends _NotedIconButtonBuilder {
  const _SimpleIconButtonBuilder(super.source);

  @override
  (Color, Color) colorsOf(ColorScheme colors) {
    return switch (source.color) {
      NotedWidgetColor.primary => (colors.primary, Colors.transparent),
      NotedWidgetColor.secondary => (colors.secondary, Colors.transparent),
      NotedWidgetColor.tertiary => (colors.tertiary, Colors.transparent),
      _ => (colors.onBackground, Colors.transparent),
    };
  }

  @override
  (double, double) sizeOf() {
    return switch (source.size) {
      NotedWidgetSize.large => (36, 54),
      NotedWidgetSize.medium => (30, 44),
      NotedWidgetSize.small => (22, 36),
    };
  }

  @override
  double elevation() {
    return 0;
  }
}

class _FilledIconButtonBuilder extends _NotedIconButtonBuilder {
  const _FilledIconButtonBuilder(super.source);

  @override
  (Color, Color) colorsOf(ColorScheme colors) {
    return switch (source.color) {
      NotedWidgetColor.primary => (colors.onPrimary, colors.primary),
      NotedWidgetColor.secondary => (colors.onSecondary, colors.secondary),
      NotedWidgetColor.tertiary => (colors.onTertiary, colors.tertiary),
      _ => (colors.onPrimary, colors.primary),
    };
  }

  @override
  (double, double) sizeOf() {
    return switch (source.size) {
      NotedWidgetSize.large => (36, 64),
      NotedWidgetSize.medium => (30, 54),
      NotedWidgetSize.small => (24, 44),
    };
  }

  @override
  double elevation() {
    return 2;
  }
}
