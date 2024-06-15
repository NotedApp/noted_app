import 'package:flutter/material.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/plugins/cookbook/cookbook_tile_content.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_tile_content.dart';
import 'package:noted_app/util/extensions/extensions.dart';
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
    final highlighted = colors.surface.brighten(
      theme.brightness == Brightness.dark ? _selectedBrightness : -_selectedBrightness,
    );

    return NotedCard(
      key: ValueKey('note-tile-$noteId'),
      size: NotedWidgetSize.small,
      color: isSelected ? highlighted : colors.surface,
      borderColor: isSelected ? colors.tertiary : null,
      onPressed: onPressed,
      onLongPressed: onLongPressed,
      child: NotedBlocSelector<NotesBloc, NotesState, NoteModel>(
        selector: (state) => state.notes[noteId] ?? NoteModel.empty(NotedPlugin.notebook),
        builder: (context, _, note) {
          if (note.field(NoteField.hidden)) {
            return _HiddenTileContent(
              title: note.field(NoteField.title),
              onPressed: onPressed,
              onLongPressed: onLongPressed,
            );
          }

          return switch (note.plugin) {
            NotedPlugin.notebook => NotebookTileContent(
                note: note,
                onPressed: onPressed,
                onLongPressed: onLongPressed,
              ),
            NotedPlugin.cookbook => CookbookTileContent(
                note: note,
                onPressed: onPressed,
                onLongPressed: onLongPressed,
              ),
            // TODO: Add climbing note content.
            NotedPlugin.climbing => const Center(child: CircularProgressIndicator()),
          };
        },
      ),
    );
  }
}

class _HiddenTileContent extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;

  const _HiddenTileContent({
    required this.title,
    required this.onPressed,
    required this.onLongPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class NotedTagRow extends StatelessWidget {
  final List<TagId> tags;
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
