import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/layout/noted_card.dart';
import 'package:noted_app/ui/common/noted_widget_config.dart';
import 'package:noted_app/ui/plugins/notebook/tiles/notebook_note_tile.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

class NotedTile extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const NotedTile({required this.child, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return NotedCard(
      size: NotedWidgetSize.small,
      color: context.colorScheme().background,
      onTap: onTap,
      child: child,
    );
  }
}

Widget buildNotedTile(NoteModel note, VoidCallback onTap) {
  return switch (note) {
    NotebookNoteModel() => NotebookNoteModelTile(note: note, onTap: onTap),
  };
}
