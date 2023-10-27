import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_tile.dart';
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

Widget buildNotedTile({required NoteModel note, required VoidCallback onTap}) {
  return switch (note) {
    NotebookNoteModel() => NotebookTile(note: note, onTap: onTap),
  };
}
