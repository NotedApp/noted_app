import 'package:flutter/material.dart';
import 'package:noted_app/catalog/mock/notebook/mock_notes.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/plugins/notebook/tiles/notebook_note_tile.dart';

class CatalogTilesPage extends StatelessWidget {
  const CatalogTilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        NotebookNoteTile(note: testNote0, onTap: () => _showTapSnackBar(context)),
        NotebookNoteTile(note: testNote1, onTap: () => _showTapSnackBar(context)),
      ],
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
