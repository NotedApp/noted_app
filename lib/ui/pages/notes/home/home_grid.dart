import 'package:flutter/material.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/notes/common/notes_grid.dart';
import 'package:noted_app/ui/pages/notes/home/home_search_bar.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return NotedBlocSelector<NotesBloc, NotesState, (List<String>, Set<String>)>(
      selector: (state) => (state.sortedNoteIds, state.selectedIds),
      builder: (context, bloc, state) => Scrollbar(
        interactive: true,
        radius: const Radius.circular(Dimens.radius_xs),
        child: CustomScrollView(
          physics: NotedWidgetConfig.scrollPhysics,
          slivers: [
            const _HomeSearchSliver(),
            _pluginsRow(context),
            notesSliverGrid(state.$1, state.$2, bloc),
          ],
        ),
      ),
    );
  }
}

class _HomeSearchSliver extends SliverToBoxAdapter {
  const _HomeSearchSliver() : super(child: const HomeSearchBar());
}

Widget _pluginsRow(BuildContext context) {
  return SliverToBoxAdapter(
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      physics: NotedWidgetConfig.scrollPhysics,
      child: Row(
        children: [
          ...NotedPlugin.values.map(
            (plugin) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: NotedPluginCard(plugin: plugin, onPressed: () => context.push(PluginRoute(plugin: plugin))),
            ),
          ),
          const SizedBox(width: 8)
        ],
      ),
    ),
  );
}
