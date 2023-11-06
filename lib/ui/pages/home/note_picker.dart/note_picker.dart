import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/home/note_picker.dart/note_picker_card.dart';
import 'package:noted_models/noted_models.dart';

class NotePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(12),
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      childAspectRatio: NotedWidgetConfig.goldenRatio,
      children: NotedPlugin.values.map((plugin) => NotePickerCard.buildCard(context: context, plugin: plugin)).toList(),
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) => NotePicker());
  }
}
