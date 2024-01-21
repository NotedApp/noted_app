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
          const SizedBox(height: 12),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2,
              children: plugins
                  .map(
                    (plugin) => NotedPluginCard(
                      plugin: plugin,
                      size: NotedWidgetSize.large,
                      width: double.infinity,
                      onPressed: () => context.push(NotesAddRoute(plugin: plugin)),
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
