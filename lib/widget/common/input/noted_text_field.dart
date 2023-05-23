import 'package:flutter/material.dart';

enum NotedTextFieldType {
  standard,
  title,
}

class NotedTextField extends StatelessWidget {
  final NotedTextFieldType type;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool autocorrect;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;

  const NotedTextField({
    required this.type,
    this.hint,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.autocorrect = true,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle? style;
    InputDecoration decoration;

    switch (type) {
      case NotedTextFieldType.standard:
        style = theme.textTheme.bodyLarge;
        decoration = InputDecoration(
          hintText: hint,
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
        decoration = const InputDecoration(border: OutlineInputBorder());
        break;
    }

    return TextField(
      style: style,
      decoration: decoration,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      autocorrect: autocorrect,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      enabled: enabled,
    );
  }
}
