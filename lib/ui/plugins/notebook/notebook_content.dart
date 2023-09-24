import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_models/noted_models.dart';

class NotebookContent extends StatelessWidget {
  final List<NotedNote> notes;

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
        itemBuilder: (context, index) => buildNotedTile(
          notes[index],
          () => context.push('/notebook/${notes[index].id}'),
        ),
      ),
    );
  }
}
