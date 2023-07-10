import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/icon/noted_icons.dart';

class NotedDropdownButton extends StatelessWidget {
  final double? width;
  final String? value;
  final List<String>? items;
  final ValueChanged<String?>? onChanged;

  const NotedDropdownButton({this.width, this.value, this.items, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: theme.colorScheme.onBackground),
    );

    return SizedBox(
      width: width,
      height: 32,
      child: DropdownButtonFormField<String>(
        items: items?.map<DropdownMenuItem<String>>(_buildMenuItem).toList(),
        dropdownColor: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        onChanged: onChanged,
        elevation: 3,
        iconSize: 20,
        value: value,
        style: theme.textTheme.bodyMedium,
        icon: Icon(NotedIcons.chevronDown, color: theme.colorScheme.onBackground),
        decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
      ),
    );
  }

  DropdownMenuItem<String> _buildMenuItem(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }
}
