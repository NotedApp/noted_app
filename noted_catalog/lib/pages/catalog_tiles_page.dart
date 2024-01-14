import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/ui/common/noted_library.dart';

class CatalogTilesPage extends StatelessWidget {
  const CatalogTilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> notes = context.select<NotesBloc, List<String>>(
      (bloc) => bloc.state.notes.keys.toList(),
    );

    return GridView.count(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 36),
      childAspectRatio: 0.8,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      crossAxisCount: 2,
      shrinkWrap: true,
      children: notes
          .map(
            (noteId) => NotedTile(noteId: noteId, onPressed: () => _showTapSnackBar(context)),
          )
          .toList(),
    );
  }

  void _showTapSnackBar(BuildContext context) {
    SnackBar snackBar = NotedSnackBar.createWithText(
      context: context,
      text: 'card tapped',
      hasClose: true,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
