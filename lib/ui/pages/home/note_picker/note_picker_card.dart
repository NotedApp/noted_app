import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class NotePickerCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final NotedRoute route;

  const NotePickerCard._(this.imageUrl, this.title, this.route);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme();

    return NotedCard(
      size: NotedWidgetSize.small,
      onPressed: () => context.popAndPush(route),
      child: Stack(
        children: [
          NotedSvg.asset(
            source: imageUrl,
            color: theme.colorScheme.tertiary.withAlpha(128),
            fit: BoxFit.cover,
          ),
          Center(
            child: StrokedText(
              title,
              style: theme.textTheme.headlineSmall,
              strokeColor: theme.colorScheme.background,
              strokeWidth: 4,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildCard({required BuildContext context, required NotedPlugin plugin}) {
    Strings strings = context.strings();

    return switch (plugin) {
      NotedPlugin.notebook => NotePickerCard._(
          'assets/svg/man_computer.svg',
          strings.plugin_notebook_title,
          NotesAddRoute(plugin: plugin),
        ),
      NotedPlugin.cookbook => NotePickerCard._(
          'assets/svg/woman_cooking.svg',
          strings.plugin_cookbook_title,
          NotesAddRoute(plugin: plugin),
        ),
    };
  }
}
