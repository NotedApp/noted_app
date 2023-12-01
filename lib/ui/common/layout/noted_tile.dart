import 'package:flutter/material.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/plugins/cookbook/cookbook_tile_content.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_tile_content.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

class NotedTile extends StatelessWidget {
  final String noteId;
  final VoidCallback? onPressed;

  const NotedTile({required this.noteId, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return NotedCard(
      size: NotedWidgetSize.small,
      color: context.colorScheme().background,
      onPressed: onPressed,
      child: NotedBlocSelector<NotesBloc, NotesState, NoteModel>(
        selector: (state) => state.notes.firstWhere(
          (note) => note.id == noteId,
          orElse: NotebookNoteModel.empty,
        ),
        builder: (context, _, note) => switch (note) {
          NotebookNoteModel() => NotebookTileContent(note: note, onPressed: onPressed),
          CookbookNoteModel() => CookbookTileContent(note: note, onPressed: onPressed),
        },
      ),
    );
  }
}

class NotedTagRow extends StatelessWidget {
  final Set<String> tags;
  final EdgeInsetsGeometry padding;

  const NotedTagRow({
    super.key,
    required this.tags,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding,
      child: Row(
        children: [
          NotedTag(
            size: NotedWidgetSize.small,
            model: const TagModel(id: 'test-0', name: 'test', color: 0xFF2A324B),
          ),
          const SizedBox(width: 4),
          NotedTag(
            size: NotedWidgetSize.small,
            model: const TagModel(id: 'test-1', name: 'work', color: 0xFFB33951),
          ),
          const SizedBox(width: 4),
          NotedTag(
            size: NotedWidgetSize.small,
            model: const TagModel(id: 'test-2', name: 'sports', color: 0xFF789395),
          ),
          const SizedBox(width: 4),
          NotedTag(
            size: NotedWidgetSize.small,
            model: const TagModel(id: 'test-3', name: 'guitar', color: 0xFF000000),
          ),
        ],
      ),
    );
  }
}
