import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

const List<NotedPlugin> plugins = NotedPlugin.values;

// coverage:ignore-file
class NotePicker extends StatelessWidget {
  const NotePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.strings().notes_addPicker, style: context.textTheme().displaySmall),
          const SizedBox(height: Dimens.spacing_m),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: Dimens.spacing_s,
              mainAxisSpacing: Dimens.spacing_s,
              childAspectRatio: 2,
              children: plugins
                  .map(
                    (plugin) => NotedPluginCard(
                      plugin: plugin,
                      size: NotedWidgetSize.large,
                      width: double.infinity,
                      onPressed: () => context.popAndPush(NotesAddRoute(plugin: plugin)),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) => const NotePicker());
  }
}
