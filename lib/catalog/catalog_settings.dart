import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/icon/noted_icons.dart';
import 'package:noted_app/ui/common/layout/noted_header_page.dart';
import 'package:noted_app/ui/settings/settings_row.dart';
import 'package:noted_app/ui/settings/style/color_switcher.dart';
import 'package:noted_app/ui/settings/style/font_switcher.dart';

class CatalogSettings extends StatelessWidget {
  const CatalogSettings({super.key});

  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).colorScheme.tertiary;

    return NotedHeaderPage(
      title: 'settings',
      hasBackButton: true,
      child: Column(
        children: [
          const SizedBox(height: 20),
          SettingsRow(
            icon: NotedIcons.eyedropper,
            title: 'colors',
            trailing: Icon(NotedIcons.chevronRight, color: iconColor),
            onPressed: () => _navigateToColors(context),
          ),
          const SizedBox(height: 4),
          SettingsRow(
            icon: NotedIcons.text,
            title: 'fonts',
            trailing: Icon(NotedIcons.chevronRight, color: iconColor),
            onPressed: () => _navigateToFonts(context),
          ),
        ],
      ),
    );
  }

  void _navigateToColors(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ColorSwitcher()));
  }

  void _navigateToFonts(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FontSwitcher()));
  }
}
