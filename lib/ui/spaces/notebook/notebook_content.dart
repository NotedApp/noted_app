import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/spaces/notebook/tiles/notebook_note_tile.dart';
import 'package:noted_models/noted_models.dart';

class NotebookContent extends StatelessWidget {
  final List<NotebookNote> notes;

  NotebookContent({required this.notes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 16, 12, 128),
      child: GridView.builder(
        itemCount: notes.length,
        physics: notedScrollPhysics,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
        ),
        itemBuilder: (context, index) => NotebookNoteTile(note: notes[index]),
      ),
    );
  }
}
