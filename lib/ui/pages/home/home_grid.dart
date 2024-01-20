import 'package:flutter/material.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_event.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';

const double _noteSpacing = 2;

// coverage:ignore-file
class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return NotedBlocSelector<NotesBloc, NotesState, (List<String>, Set<String>)>(
      selector: (state) => (state.sortedNoteIds, state.selectedIds),
      builder: (context, bloc, state) {
        final sortedIds = state.$1;
        final isSelecting = state.$2.isNotEmpty;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GridView.builder(
            itemCount: sortedIds.length,
            padding: const EdgeInsets.only(top: 16, bottom: 128),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: _noteSpacing,
              crossAxisSpacing: _noteSpacing,
              childAspectRatio: NotedWidgetConfig.tileAspectRatio,
            ),
            itemBuilder: (context, index) {
              final isSelected = state.$2.contains(sortedIds[index]);

              final onPressed = isSelecting
                  ? () => bloc.add(NotesToggleSelectionEvent(sortedIds[index]))
                  : () => context.push(NotesEditRoute(noteId: sortedIds[index]));

              final onLongPressed = isSelecting ? null : () => bloc.add(NotesToggleSelectionEvent(sortedIds[index]));

              return NotedTile(
                noteId: sortedIds[index],
                isSelected: isSelected,
                onPressed: onPressed,
                onLongPressed: onLongPressed,
              );
            },
          ),
        );
      },
    );
  }
}
