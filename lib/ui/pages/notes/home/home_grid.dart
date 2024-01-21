import 'package:flutter/material.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/notes/common/notes_grid.dart';
import 'package:noted_app/ui/pages/notes/home/home_search_bar.dart';
import 'package:noted_models/noted_models.dart';

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
          notesSliverGrid(state.$1, state.$2, bloc),
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
