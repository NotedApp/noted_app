import 'package:flutter/material.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/plugins/cookbook/cookbook_tile.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_tile.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

class NotedTileBuilder extends StatelessWidget {
  final String noteId;
  final VoidCallback? onPressed;

  const NotedTileBuilder({required this.noteId, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return NotedBlocSelector<NotesBloc, NotesState, NoteModel>(
      selector: (state) => state.notes.firstWhere(
        (note) => note.id == noteId,
        orElse: NotebookNoteModel.empty,
      ),
      builder: (context, _, note) => switch (note) {
        NotebookNoteModel() => NotebookTile(note: note, onPressed: onPressed),
        CookbookNoteModel() => CookbookTile(note: note, onPressed: onPressed),
      },
    );
  }
}

class NotedTile extends StatelessWidget {
  final Widget child;
  final Set<String> tags;
  final VoidCallback? onPressed;

  const NotedTile({required this.child, this.tags = const {}, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    Widget contents = tags.isNotEmpty ? Column(children: [Expanded(child: child), _NotedTagRow(tags: tags)]) : child;

    return NotedCard(
      size: NotedWidgetSize.small,
      color: context.colorScheme().background,
      onPressed: onPressed,
      child: contents,
    );
  }
}

class _NotedTagRow extends StatelessWidget {
  final Set<String> tags;

  const _NotedTagRow({required this.tags});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 4, 10, 10),
        child: Row(
          children: [
            NotedTag(
              size: NotedWidgetSize.small,
              model: TagModel(id: 'test-0', name: 'test', color: 0xFF2A324B),
            ),
            SizedBox(width: 4),
            NotedTag(
              size: NotedWidgetSize.small,
              model: TagModel(id: 'test-1', name: 'work', color: 0xFFB33951),
            ),
            SizedBox(width: 4),
            NotedTag(
              size: NotedWidgetSize.small,
              model: TagModel(id: 'test-2', name: 'sports', color: 0xFF789395),
            ),
            SizedBox(width: 4),
            NotedTag(
              size: NotedWidgetSize.small,
              model: TagModel(id: 'test-3', name: 'guitar', color: 0xFF000000),
            ),
          ],
        ),
      ),
    );
  }
}
