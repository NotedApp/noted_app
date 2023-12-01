import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/home/note_picker.dart/note_picker_card.dart';
import 'package:noted_app/util/extensions.dart';
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
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: NotedWidgetConfig.goldenRatio,
              children: plugins.map((plugin) => NotePickerCard.buildCard(context: context, plugin: plugin)).toList(),
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
