import 'package:flutter/material.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';

const double _noteSpacing = 4;

// coverage:ignore-file
class HomeContent extends StatelessWidget {
  final Set<String> selectedIds;
  final void Function(String) toggleSelection;

  const HomeContent({
    super.key,
    required this.selectedIds,
    required this.toggleSelection,
  });

  @override
  Widget build(BuildContext context) {
    final isSelecting = selectedIds.isNotEmpty;

    return NotedBlocSelector<NotesBloc, NotesState, List<String>>(
      selector: (state) => state.sortedNoteIds,
      builder: (context, _, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
          itemCount: state.length,
          padding: const EdgeInsets.only(top: 16, bottom: 128),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: _noteSpacing,
            crossAxisSpacing: _noteSpacing,
            childAspectRatio: NotedWidgetConfig.tileAspectRatio,
          ),
          itemBuilder: (context, index) {
            final isSelected = selectedIds.contains(state[index]);

            final onPressed = isSelecting
                ? () => toggleSelection(state[index])
                : () => context.push(NotesEditRoute(noteId: state[index]));

            final onLongPressed = isSelecting ? () {} : () => toggleSelection(state[index]);

            return NotedTile(
              noteId: state[index],
              isSelected: isSelected,
              onPressed: onPressed,
              onLongPressed: onLongPressed,
            );
          },
        ),
      ),
    );
  }
}
