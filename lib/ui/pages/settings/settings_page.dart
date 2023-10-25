import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/settings/settings_row.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatelessWidget {
  final Future<String> _getVersion = PackageInfo.fromPlatform().then((value) => value.version);

  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();

    return NotedHeaderPage(
      hasBackButton: true,
      title: strings.settings_title,
      child: Column(
        children: [
          SizedBox(height: 16),
          SettingsRow(
            icon: NotedIcons.account,
            title: strings.settings_account_title,
            hasArrow: true,
            onPressed: () => context.push('/settings/account'),
          ),
          SettingsRow(
            icon: NotedIcons.brush,
            title: strings.settings_style_title,
            hasArrow: true,
            onPressed: () => context.push('/settings/style'),
          ),
          SettingsRow(
            icon: NotedIcons.plug,
            title: strings.settings_plugins_title,
            hasArrow: true,
            onPressed: () => showUnimplementedSnackBar(context),
          ),
          SettingsRow(
            icon: NotedIcons.trash,
            title: strings.settings_deleted_title,
            hasArrow: true,
            onPressed: () => showUnimplementedSnackBar(context),
          ),
          SettingsRow(
            icon: NotedIcons.creditCard,
            title: strings.settings_subscriptions_title,
            hasArrow: true,
            onPressed: () => showUnimplementedSnackBar(context),
          ),
          SettingsRow(
            icon: NotedIcons.help,
            title: strings.settings_help_title,
            hasArrow: true,
            onPressed: () => showUnimplementedSnackBar(context),
          ),
          Spacer(),
          FutureBuilder<String>(
            future: _getVersion,
            initialData: strings.app_title,
            builder: (context, info) {
              return Text(
                '${strings.app_title} v${info.data}',
                style: context.textTheme().labelSmall,
              );
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
