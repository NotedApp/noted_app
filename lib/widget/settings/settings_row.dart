import 'package:flutter/material.dart';

class SettingsRow extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onPressed;

  const SettingsRow({
    this.icon,
    required this.title,
    this.trailing,
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
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(icon, size: 24, color: theme.colorScheme.tertiary),
                ),
              Expanded(child: Text(title, style: theme.textTheme.bodyLarge)),
              if (trailing != null)
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: trailing,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
