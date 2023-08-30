import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/spaces/notebook/tiles/notebook_note_tile.dart';
import 'package:noted_models/noted_models.dart';

class NotebookContent extends StatelessWidget {
  final List<NotebookNote> notes;

  NotebookContent({required this.notes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
      child: GridView.builder(
        itemCount: notes.length,
        physics: notedScrollPhysics,
        padding: EdgeInsets.only(bottom: 128),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemBuilder: (context, index) => NotebookNoteTile(
          onTap: () => context.push('/notebook/${notes[index].id}'),
          note: notes[index],
        ),
      ),
    );
  }
}
