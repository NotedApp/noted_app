import 'package:flutter/material.dart';
import 'package:noted_app/ui/pages/edit/edit_page.dart';
import 'package:noted_app/ui/plugins/cookbook/cookbook_edit_content.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_edit_content.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class EditContent extends StatelessWidget {
  final NoteModel note;
  final NoteUpdateCallback updateNote;

  const EditContent({super.key, required this.note, required this.updateNote});

  @override
  Widget build(BuildContext context) {
    ValueKey key = ValueKey(note.id);

    return switch (note) {
      NotebookNoteModel() => NotebookEditContent(note: note as NotebookNoteModel, updateNote: updateNote, key: key),
      CookbookNoteModel() => CookbookEditContent(note: note as CookbookNoteModel, updateNote: updateNote, key: key),
    };
  }
}
