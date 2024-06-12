import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/button/noted_icon_button.dart';
import 'package:noted_app/ui/common/noted_widget_config.dart';

enum NotedTextFieldType {
  outlined,
  title,
  plain,
}

class NotedTextField extends StatelessWidget {
  final NotedTextFieldType type;
  final FocusNode? focusNode;
  final String? name;
  final String? hint;
  final String? errorText;
  final bool showErrorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autocorrect;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final IconData? icon;
  final VoidCallback? onIconPressed;
  final double? strokeWidth;

  const NotedTextField({
    required this.type,
    this.focusNode,
    this.name,
    this.hint,
    this.errorText,
    this.showErrorText = false,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.autocorrect = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.icon,
    this.onIconPressed,
    this.strokeWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    _NotedTextFieldBuilder builder = switch (type) {
      NotedTextFieldType.outlined => _StandardTextFieldBuilder(this, strokeWidth ?? 1),
      NotedTextFieldType.title => _TitleTextFieldBuilder(this),
      NotedTextFieldType.plain => _PlainTextFieldBuilder(this),
    };

    String? resolvedErrorText = errorText != null
        ? showErrorText
            ? errorText
            : ''
        : null;

    TextStyle? errorStyle = showErrorText
        ? theme.textTheme.labelSmall?.copyWith(height: 1, color: theme.colorScheme.error)
        : const TextStyle(height: 0);

    TextStyle? style = builder.styleOf(theme.textTheme);

    TextStyle? hintStyle = style?.copyWith(color: theme.colorScheme.onBackground.withOpacity(0.4));

    NotedIconButton? suffix = icon == null
        ? null
        : NotedIconButton(
            type: NotedIconButtonType.simple,
            size: NotedWidgetSize.small,
            icon: icon,
            onPressed: onIconPressed,
          );

    InputDecoration decoration = builder.decorationOf(theme.colorScheme).copyWith(
          isDense: true,
          hintText: hint,
          hintStyle: hintStyle,
          labelStyle: hintStyle,
          errorText: resolvedErrorText,
          errorStyle: errorStyle,
          suffixIcon: suffix,
        );

    return TextFormField(
      focusNode: focusNode,
      style: style,
      decoration: decoration,
      controller: controller,
      keyboardType: keyboardType,
      keyboardAppearance: theme.brightness,
      obscureText: obscureText,
      autocorrect: autocorrect,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      enabled: enabled,
    );
  }
}

/// Provides a set of methods to define the appearance of a type of text field.
abstract class _NotedTextFieldBuilder {
  final NotedTextField source;

  const _NotedTextFieldBuilder(this.source);

  /// Return a text style for the text field content.
  TextStyle? styleOf(TextTheme theme);

  /// Return an input decoration for the text field.
  InputDecoration decorationOf(ColorScheme scheme);
}

class _StandardTextFieldBuilder extends _NotedTextFieldBuilder {
  final double strokeWidth;

  const _StandardTextFieldBuilder(super.source, this.strokeWidth);

  @override
  TextStyle? styleOf(TextTheme theme) {
    return theme.bodyLarge;
  }

  @override
  InputDecoration decorationOf(ColorScheme scheme) {
    return InputDecoration(
      labelText: source.name,
      contentPadding: EdgeInsets.fromLTRB(16, 10, source.icon == null ? 16 : 48, 10),
      border: MaterialStateOutlineInputBorder.resolveWith(
        (states) {
          var color = scheme.onBackground;

          if (states.contains(WidgetState.error)) {
            color = scheme.error;
          }

          if (states.contains(WidgetState.disabled)) {
            color = color.withAlpha(128);
          }

          return OutlineInputBorder(
            borderSide: BorderSide(color: color, width: strokeWidth),
            borderRadius: BorderRadius.circular(12),
          );
        },
      ),
    );
  }
}

class _TitleTextFieldBuilder extends _NotedTextFieldBuilder {
  const _TitleTextFieldBuilder(super.source);

  @override
  TextStyle? styleOf(TextTheme theme) {
    return theme.displaySmall;
  }

  @override
  InputDecoration decorationOf(ColorScheme scheme) {
    return const InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 5),
      border: OutlineInputBorder(borderSide: BorderSide.none),
    );
  }
}

class _PlainTextFieldBuilder extends _NotedTextFieldBuilder {
  const _PlainTextFieldBuilder(super.source);

  @override
  TextStyle? styleOf(TextTheme theme) {
    return theme.bodyLarge;
  }

  @override
  InputDecoration decorationOf(ColorScheme scheme) {
    return InputDecoration(
      labelText: source.name,
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      border: const OutlineInputBorder(borderSide: BorderSide.none),
    );
  }
}
