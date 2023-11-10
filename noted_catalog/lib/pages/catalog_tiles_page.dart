import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_tile_content.dart';
import 'package:noted_catalog/notebook/mock_notes.dart';

class CatalogTilesPage extends StatelessWidget {
  const CatalogTilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      childAspectRatio: 0.8,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        NotebookTileContent(note: testNote0, onPressed: () => _showTapSnackBar(context)),
        NotebookTileContent(note: testNote1, onPressed: () => _showTapSnackBar(context)),
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
