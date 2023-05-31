import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/button/noted_icon_button.dart';

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
    bool hasError = errorText != null;
    ThemeData theme = Theme.of(context);
    TextStyle? style;
    InputDecoration decoration;

    String? resolvedErrorText = hasError
        ? showErrorText
            ? errorText
            : ''
        : null;

    TextStyle? errorStyle = showErrorText
        ? theme.textTheme.labelSmall?.copyWith(height: 1, color: theme.colorScheme.error)
        : const TextStyle(height: 0);

    switch (type) {
      case NotedTextFieldType.standard:
        style = theme.textTheme.bodyLarge;
        decoration = InputDecoration(
          isDense: true,
          labelText: name,
          hintText: hint,
          errorText: resolvedErrorText,
          errorStyle: errorStyle,
          contentPadding: EdgeInsets.fromLTRB(16, 10, icon == null ? 16 : 48, 10),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.onBackground),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.error),
            borderRadius: BorderRadius.circular(8),
          ),
        );
        break;
      case NotedTextFieldType.title:
        style = theme.textTheme.displaySmall;
        decoration = InputDecoration(
          isDense: true,
          hintText: hint,
          errorText: resolvedErrorText,
          errorStyle: errorStyle,
          contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        );
        break;
    }

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
              size: NotedIconButtonSize.small,
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
