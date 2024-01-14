import 'package:flutter/material.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/plugins/cookbook/cookbook_tile_content.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_tile_content.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart' hide Brightness;

const double _selectedBrightness = 0.2;

class NotedTile extends StatelessWidget {
  final String noteId;
  final bool isSelected;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;

  const NotedTile({
    required this.noteId,
    this.isSelected = false,
    this.onPressed,
    this.onLongPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme();
    final colors = theme.colorScheme;
    final highlighted = colors.background.brighten(
      theme.brightness == Brightness.dark ? _selectedBrightness : -_selectedBrightness,
    );

    return NotedCard(
      key: ValueKey('note-tile-$noteId'),
      size: NotedWidgetSize.small,
      color: isSelected ? highlighted : colors.background,
      borderColor: isSelected ? colors.tertiary : null,
      onPressed: onPressed,
      onLongPressed: onLongPressed,
      child: NotedBlocSelector<NotesBloc, NotesState, NoteModel>(
        selector: (state) => state.notes[noteId] ?? NotebookNoteModel.empty(),
        builder: (context, _, note) => switch (note) {
          NotebookNoteModel() => NotebookTileContent(note: note, onPressed: onPressed, onLongPressed: onLongPressed),
          CookbookNoteModel() => CookbookTileContent(note: note, onPressed: onPressed, onLongPressed: onLongPressed),
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
