import 'package:flutter/material.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_event.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/home/home_search_bar.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_models/noted_models.dart';

const double _noteSpacing = 8;

// coverage:ignore-file
class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return NotedBlocSelector<NotesBloc, NotesState, (List<String>, Set<String>)>(
      selector: (state) => (state.sortedNoteIds, state.selectedIds),
      builder: (context, bloc, state) => CustomScrollView(
        physics: NotedWidgetConfig.scrollPhysics,
        slivers: [
          const _HomeSearchSliver(),
          _pluginsRow(),
          _homeGrid(state.$1, state.$2, bloc),
        ],
      ),
    );
  }
}

class _HomeSearchSliver extends SliverToBoxAdapter {
  const _HomeSearchSliver() : super(child: const HomeSearchBar());
}

Widget _pluginsRow() {
  const List<NotedPlugin> plugins = [NotedPlugin.notebook, NotedPlugin.cookbook];

  return SliverToBoxAdapter(
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      physics: NotedWidgetConfig.scrollPhysics,
      child: Row(
        children: [
          ...plugins.map(
            (plugin) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: NotedPluginCard(
                plugin: plugin,
                // TODO: Implement onPressed.
                onPressed: () {},
              ),
            ),
          ),
          const SizedBox(width: 8)
        ],
      ),
    ),
  );
}

Widget _homeGrid(List<String> sortedIds, Set<String> selectedIds, NotesBloc bloc) {
  final isSelecting = selectedIds.isNotEmpty;

  return SliverPadding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 128),
    sliver: SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: _noteSpacing,
        crossAxisSpacing: _noteSpacing,
        childAspectRatio: NotedWidgetConfig.tileAspectRatio,
      ),
      itemBuilder: (context, index) {
        final isSelected = selectedIds.contains(sortedIds[index]);

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
      itemCount: sortedIds.length,
    ),
  );
}
