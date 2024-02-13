import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_models/noted_models.dart';

import 'mocks/mock_classes.dart';

final Map<String, NoteModel> testNotes = Map.fromEntries([
  NoteModel.value(
    NotedPlugin.notebook,
    overrides: [
      const NoteFieldValue(NoteField.title, 'notebook'),
      const NoteFieldValue(NoteField.tagIds, ['0']),
    ],
  ).copyWith(id: 'notebook0'),
  NoteModel.value(
    NotedPlugin.notebook,
    overrides: [const NoteFieldValue(NoteField.title, '')],
  ).copyWith(id: 'notebook1'),
  NoteModel.value(
    NotedPlugin.notebook,
    overrides: [const NoteFieldValue(NoteField.hidden, true)],
  ).copyWith(id: 'notebook2'),
  NoteModel.value(
    NotedPlugin.cookbook,
    overrides: [
      const NoteFieldValue(NoteField.title, 'cookbook'),
      const NoteFieldValue(NoteField.tagIds, ['0']),
      const NoteFieldValue(NoteField.cookbookPrepTime, '1hr'),
      const NoteFieldValue(NoteField.cookbookCookTime, '15m'),
      const NoteFieldValue(NoteField.cookbookDifficulty, 3),
    ],
  ).copyWith(id: 'cookbook0'),
  NoteModel.value(
    NotedPlugin.cookbook,
    overrides: [
      const NoteFieldValue(NoteField.title, 'cookbook'),
      const NoteFieldValue(NoteField.link, 'https://www.onceuponachef.com/recipes/roasted-brussels-sprouts.html'),
      const NoteFieldValue(NoteField.tagIds, ['0']),
      const NoteFieldValue(NoteField.cookbookPrepTime, '1hr'),
      const NoteFieldValue(NoteField.cookbookCookTime, '15m'),
      const NoteFieldValue(NoteField.cookbookDifficulty, 3),
    ],
  ).copyWith(id: 'cookbook1'),
  NoteModel.value(
    NotedPlugin.climbing,
    overrides: [
      const NoteFieldValue(NoteField.title, 'climbing'),
      const NoteFieldValue(NoteField.tagIds, ['0']),
    ],
  ).copyWith(id: 'climbing0'),
].map((model) => MapEntry(model.id, model)));

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
