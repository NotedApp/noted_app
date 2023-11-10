import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_models/noted_models.dart';

import 'mocks/mock_classes.dart';

final List<NoteModel> testNotes = [
  NotebookNoteModel(
    id: 'notebook0',
    title: 'notebook',
    document: DocumentUtil.emptyDocument,
    tagIds: {'0'},
  ),
  NotebookNoteModel(
    id: 'notebook1',
    title: '',
    document: DocumentUtil.emptyDocument,
  ),
  CookbookNoteModel(
    id: 'cookbook0',
    title: 'cookbook',
    url: '',
    prepTime: '',
    cookTime: '',
    difficulty: 3,
    document: DocumentUtil.emptyDocument,
  ),
  CookbookNoteModel(
    id: 'cookbook1',
    title: '',
    url: '',
    prepTime: '',
    cookTime: '',
    difficulty: 3,
    document: DocumentUtil.emptyDocument,
  ),
];

class TestWrapper extends StatelessWidget {
  final Widget child;
  final NotesBloc? notesBloc;

  final MockNotesBloc mockNotesBloc = MockNotesBloc();

  TestWrapper({required this.child, this.notesBloc, super.key}) {
    when(() => mockNotesBloc.state).thenAnswer((_) => NotesState.success(notes: testNotes));
    when(() => mockNotesBloc.stream).thenAnswer((_) => Stream.value(NotesState.success(notes: testNotes)));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: Strings.localizationsDelegates,
      supportedLocales: Strings.supportedLocales,
      home: Material(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<NotesBloc>.value(value: notesBloc ?? mockNotesBloc),
          ],
          child: child,
        ),
      ),
    );
  }
}
