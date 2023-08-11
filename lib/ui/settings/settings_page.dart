import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/settings/settings_row.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/routing/noted_router.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();

    return NotedHeaderPage(
      hasBackButton: true,
      child: Column(
        children: [
          SettingsRow(
            icon: NotedIcons.account,
            title: strings.settings_accountTitle,
            hasArrow: true,
            onPressed: () => context.push('/settings/account'),
          ),
          SettingsRow(
            icon: NotedIcons.brush,
            title: strings.settings_styleTitle,
            hasArrow: true,
            onPressed: () => context.push('/settings/style'),
          ),
          SettingsRow(
            icon: NotedIcons.plug,
            title: strings.settings_pluginsTitle,
            hasArrow: true,
            onPressed: () => context.push('/settings/plugins'),
          ),
          SettingsRow(
            icon: NotedIcons.trash,
            title: strings.settings_deletedTitle,
            hasArrow: true,
            onPressed: () => context.push('/settings/deleted'),
          ),
          SettingsRow(
            icon: NotedIcons.creditCard,
            title: strings.settings_subscriptionsTitle,
            hasArrow: true,
            onPressed: () => context.push('/settings/subscriptions'),
          ),
          SettingsRow(
            icon: NotedIcons.help,
            title: strings.settings_helpTitle,
            hasArrow: true,
            onPressed: () => context.push('/settings/help'),
          ),
        ],
      ),
    );
  }
}
