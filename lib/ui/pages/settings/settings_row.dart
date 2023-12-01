import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';

// coverage:ignore-file
class SettingsRow extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Widget? trailing;
  final bool hasArrow;
  final VoidCallback? onPressed;

  const SettingsRow({
    this.icon,
    required this.title,
    this.trailing,
    this.hasArrow = false,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 54,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Row(
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(icon, size: 24, color: theme.colorScheme.tertiary),
                ),
              Expanded(child: Text(title, style: theme.textTheme.bodyLarge)),
              if (trailing != null || hasArrow)
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: trailing ?? Icon(NotedIcons.chevronRight, size: 24, color: theme.colorScheme.tertiary),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
