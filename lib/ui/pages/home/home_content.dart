import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_models/noted_models.dart';

class HomeContent extends StatelessWidget {
  final List<NoteModel> notes;

  HomeContent({required this.notes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
      child: GridView.builder(
        itemCount: notes.length,
        physics: NotedWidgetConfig.scrollPhysics,
        padding: EdgeInsets.only(bottom: 128),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: NotedWidgetConfig.tileAspectRatio,
        ),
        itemBuilder: (context, index) => NotedTile.buildTile(
          note: notes[index],
          onTap: () => context.push(NotesEditRoute(noteId: notes[index].id)),
        ),
      ),
    );
  }
}
