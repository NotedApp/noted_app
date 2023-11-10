import 'package:flutter/material.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';

// coverage:ignore-file
class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotedBlocSelector<NotesBloc, NotesState, List<String>>(
      selector: (state) => state.notes.map((note) => note.id).toList(),
      builder: (context, _, state) => Padding(
        padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
        child: GridView.builder(
          itemCount: state.length,
          padding: EdgeInsets.only(bottom: 128),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: NotedWidgetConfig.tileAspectRatio,
          ),
          itemBuilder: (context, index) => NotedTileBuilder(
            noteId: state[index],
            onPressed: () => context.push(NotesEditRoute(noteId: state[index])),
          ),
        ),
      ),
    );
  }
}
