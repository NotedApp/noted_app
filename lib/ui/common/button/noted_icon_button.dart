import 'package:flutter/material.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/ui/common/noted_widget_config.dart';

enum NotedIconButtonType {
  simple,
  filled,
}

class NotedIconButton extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
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
  /// [color] defines the color scheme of the button.
  ///  - The default differs depending on the type of button.
  ///  - The colors can be override with [iconColor] and [backgroundColor].
  const NotedIconButton({
    required this.icon,
    this.iconWidget,
    required this.type,
    this.size = NotedWidgetSize.medium,
    this.color,
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

    OutlinedBorder shape = CircleBorder(
      side: outlineColor != null ? BorderSide(color: outlineColor!) : BorderSide.none,
    );

    ButtonStyle style = builder.styleOf(colorScheme).copyWith(
          iconColor: iconColor?.materialState(),
          backgroundColor: backgroundColor?.materialState(),
          overlayColor: iconColor?.withOpacity(NotedWidgetConfig.buttonOverlayOpacity).materialState(),
          padding: EdgeInsets.zero.materialState(),
          minimumSize: Size.zero.materialState(),
          shape: shape.materialState(),
        );

    double widgetSize = builder.sizeOf();

    return SizedBox(
      width: widgetSize,
      height: widgetSize,
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: style,
        child: iconWidget ?? Icon(icon),
      ),
    );
  }
}

abstract class _NotedIconButtonBuilder {
  final NotedIconButton source;

  const _NotedIconButtonBuilder(this.source);

  ButtonStyle styleOf(ColorScheme colors);

  double sizeOf();
}

class _SimpleIconButtonBuilder extends _NotedIconButtonBuilder {
  const _SimpleIconButtonBuilder(super.source);

  @override
  ButtonStyle styleOf(ColorScheme colors) {
    (Color, Color) buttonColors = switch (source.color) {
      NotedWidgetColor.primary => (colors.primary, Colors.transparent),
      NotedWidgetColor.secondary => (colors.secondary, Colors.transparent),
      NotedWidgetColor.tertiary => (colors.tertiary, Colors.transparent),
      _ => (colors.onBackground, Colors.transparent),
    };

    double iconSize = switch (source.size) {
      NotedWidgetSize.large => 32,
      NotedWidgetSize.medium => 26,
      NotedWidgetSize.small => 18,
    };

    return ButtonStyle(
      iconColor: buttonColors.$1.materialState(),
      backgroundColor: buttonColors.$2.materialState(),
      overlayColor: buttonColors.$1.withOpacity(NotedWidgetConfig.buttonOverlayOpacity).materialState(),
      iconSize: iconSize.materialState(),
      fixedSize: Size.square(sizeOf()).materialState(),
      elevation: 0.toDouble().materialState(),
    );
  }

  @override
  double sizeOf() {
    return switch (source.size) {
      NotedWidgetSize.large => 54,
      NotedWidgetSize.medium => 44,
      NotedWidgetSize.small => 36,
    };
  }
}

class _FilledIconButtonBuilder extends _NotedIconButtonBuilder {
  const _FilledIconButtonBuilder(super.source);

  @override
  ButtonStyle styleOf(ColorScheme colors) {
    (Color, Color) buttonColors = switch (source.color) {
      NotedWidgetColor.primary => (colors.onPrimary, colors.primary),
      NotedWidgetColor.secondary => (colors.onSecondary, colors.secondary),
      NotedWidgetColor.tertiary => (colors.onTertiary, colors.tertiary),
      _ => (colors.onPrimary, colors.primary),
    };

    double iconSize = switch (source.size) {
      NotedWidgetSize.large => 36,
      NotedWidgetSize.medium => 30,
      NotedWidgetSize.small => 24,
    };

    return ButtonStyle(
      iconColor: buttonColors.$1.materialState(),
      backgroundColor: buttonColors.$2.materialState(),
      overlayColor: buttonColors.$1.withOpacity(NotedWidgetConfig.buttonOverlayOpacity).materialState(),
      iconSize: iconSize.materialState(),
      fixedSize: Size.square(sizeOf()).materialState(),
      elevation: 2.toDouble().materialState(),
    );
  }

  @override
  double sizeOf() {
    return switch (source.size) {
      NotedWidgetSize.large => 64,
      NotedWidgetSize.medium => 54,
      NotedWidgetSize.small => 44,
    };
  }
}
