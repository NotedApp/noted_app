import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/button/noted_icon_button.dart';
import 'package:noted_app/widget/common/noted_widget_config.dart';

enum NotedTextFieldType {
  standard,
  title,
}

class NotedTextField extends StatelessWidget {
  final NotedTextFieldType type;
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

  const NotedTextField({
    required this.type,
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    _NotedTextFieldBuilder builder = switch (type) {
      NotedTextFieldType.standard => _StandardTextFieldBuilder(this),
      NotedTextFieldType.title => _TitleTextFieldBuilder(this),
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

    InputDecoration decoration = builder.decorationOf(theme.colorScheme).copyWith(
          isDense: true,
          hintText: hint,
          errorText: resolvedErrorText,
          errorStyle: errorStyle,
        );

    List<Widget> children = [
      TextFormField(
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
      ),
    ];

    if (icon != null) {
      children.add(
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: NotedIconButton(
              type: NotedIconButtonType.simple,
              size: NotedWidgetSize.small,
              icon: icon!,
              onPressed: onIconPressed,
            ),
          ),
        ),
      );
    }

    return Stack(children: children);
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
  const _StandardTextFieldBuilder(super.source);

  @override
  TextStyle? styleOf(TextTheme theme) {
    return theme.bodyLarge;
  }

  @override
  InputDecoration decorationOf(ColorScheme scheme) {
    return InputDecoration(
      labelText: source.name,
      contentPadding: EdgeInsets.fromLTRB(16, 10, source.icon == null ? 16 : 48, 10),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: scheme.onBackground),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: scheme.error),
        borderRadius: BorderRadius.circular(8),
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
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    );
  }
}
