import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/settings/settings_row.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/ui/router/noted_router.dart';

class StylePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();

    return NotedHeaderPage(
      hasBackButton: true,
      title: strings.settings_style_title,
      child: Column(
        children: [
          SizedBox(height: 16),
          SettingsRow(
            icon: NotedIcons.eyedropper,
            title: strings.settings_style_themeTitle,
            hasArrow: true,
            onPressed: () => context.push('/settings/style/theme'),
          ),
          SettingsRow(
            icon: NotedIcons.text,
            title: strings.settings_style_fontsTitle,
            hasArrow: true,
            onPressed: () => context.push('/settings/style/fonts'),
          ),
          SettingsRow(
            icon: NotedIcons.textColor,
            title: strings.settings_style_textColors,
            hasArrow: true,
            onPressed: () => context.push('/settings/style/text-colors'),
          ),
          SettingsRow(
            icon: NotedIcons.backgroundColor,
            title: strings.settings_style_highlightColors,
            hasArrow: true,
            onPressed: () => context.push('/settings/style/highlight-colors'),
          ),
        ],
      ),
    );
  }
}
