import 'package:flutter/material.dart';
import 'package:noted_app/catalog/mock/notebook/mock_notes.dart';
import 'package:noted_app/widget/spaces/notebook/tiles/notebook_note_tile.dart';

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
        NotebookNoteTile(note: testNote0),
        NotebookNoteTile(note: testNote1),
      ],
    );
  }
}
