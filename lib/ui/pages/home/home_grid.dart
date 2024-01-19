import 'package:flutter/material.dart';
import 'package:noted_app/state/home/home_bloc.dart';
import 'package:noted_app/state/home/home_event.dart';
import 'package:noted_app/state/home/home_state.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';

const double _noteSpacing = 4;

// coverage:ignore-file
class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return NotedBlocSelector<HomeBloc, HomeState, Set<String>>(
      selector: (state) => state.selectedIds,
      builder: (_, bloc, selectedIds) {
        final isSelecting = selectedIds.isNotEmpty;

        return NotedBlocSelector<NotesBloc, NotesState, List<String>>(
          selector: (state) => state.sortedNoteIds,
          selectedListener: (context, sortedIds) => bloc.add(HomeUpdateAvailableEvent(sortedIds.toSet())),
          builder: (context, _, sortedIds) => Padding(
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
                final isSelected = selectedIds.contains(sortedIds[index]);

                final onPressed = isSelecting
                    ? () => bloc.add(HomeToggleSelectionEvent(sortedIds[index]))
                    : () => context.push(NotesEditRoute(noteId: sortedIds[index]));

                final onLongPressed = isSelecting ? () {} : () => bloc.add(HomeToggleSelectionEvent(sortedIds[index]));

                return NotedTile(
                  noteId: sortedIds[index],
                  isSelected: isSelected,
                  onPressed: onPressed,
                  onLongPressed: onLongPressed,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
