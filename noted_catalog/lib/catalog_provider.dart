import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_models/noted_models.dart';

class CatalogProvider extends StatelessWidget {
  final Widget child;
  final NotesBloc? notesBloc;

  final _MockNotesBloc _mockNotesBloc = _MockNotesBloc();

  CatalogProvider({super.key, required this.child, this.notesBloc}) {
    when(() => _mockNotesBloc.state).thenAnswer((_) => NotesState.success(notes: _testNotes));
    when(() => _mockNotesBloc.stream).thenAnswer((_) => Stream.value(NotesState.success(notes: _testNotes)));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsBloc()),
        BlocProvider<NotesBloc>.value(value: notesBloc ?? _mockNotesBloc),
      ],
      child: child,
    );
  }
}

class _MockNotesBloc extends Mock implements NotesBloc {}

final Map<String, NoteModel> _testNotes = Map.fromEntries([
  NoteModel.empty(NotedPlugin.notebook).copyWith(id: 'notebook0'),
  NoteModel.value(
    NotedPlugin.notebook,
    overrides: [const NoteFieldValue(NoteField.title, 'test note')],
  ).copyWith(id: 'notebook1'),
  NoteModel.value(
    NotedPlugin.notebook,
    overrides: [
      const NoteFieldValue(NoteField.title, 'test note'),
      const NoteFieldValue(NoteField.document, Document.mock),
    ],
  ).copyWith(id: 'notebook2'),
  NoteModel.value(
    NotedPlugin.notebook,
    overrides: [
      const NoteFieldValue(NoteField.title, 'test note'),
      const NoteFieldValue(NoteField.document, Document.mock),
      const NoteFieldValue(NoteField.tagIds, ['0']),
    ],
  ).copyWith(id: 'notebook3'),
  NoteModel.value(
    NotedPlugin.cookbook,
    overrides: [
      const NoteFieldValue(NoteField.title, 'empty recipe'),
      const NoteFieldValue(NoteField.document, Document.mock),
    ],
  ).copyWith(id: 'cookbook0'),
  NoteModel.value(
    NotedPlugin.cookbook,
    overrides: [
      const NoteFieldValue(NoteField.title, 'a recipe with a super duper long title'),
      const NoteFieldValue(NoteField.document, Document.mock),
      const NoteFieldValue(NoteField.tagIds, ['0']),
    ],
  ).copyWith(id: 'cookbook1'),
  NoteModel.value(
    NotedPlugin.cookbook,
    overrides: [
      const NoteFieldValue(NoteField.title, 'a recipe with a super duper long title'),
      const NoteFieldValue(NoteField.link, 'onceuponachef.com/rec'),
      const NoteFieldValue(NoteField.document, Document.mock),
      const NoteFieldValue(NoteField.cookbookCookTime, '30m'),
      const NoteFieldValue(NoteField.cookbookDifficulty, 3),
    ],
  ).copyWith(id: 'cookbook2'),
  NoteModel.value(
    NotedPlugin.cookbook,
    overrides: [
      const NoteFieldValue(NoteField.title, 'a recipe with a super duper long title'),
      const NoteFieldValue(NoteField.link, 'https://www.onceuponachef.com/recipes/roasted-brussels-sprouts.html'),
      const NoteFieldValue(NoteField.cookbookCookTime, '30m'),
      const NoteFieldValue(NoteField.cookbookDifficulty, 3),
    ],
  ).copyWith(id: 'cookbook3'),
  NoteModel.value(
    NotedPlugin.cookbook,
    overrides: [
      const NoteFieldValue(NoteField.title, 'miso salmon'),
      const NoteFieldValue(NoteField.link, 'https://www.justonecookbook.com/miso-salmon/'),
      const NoteFieldValue(NoteField.tagIds, ['0']),
      const NoteFieldValue(NoteField.cookbookPrepTime, '1hr'),
      const NoteFieldValue(NoteField.cookbookCookTime, '15m'),
      const NoteFieldValue(NoteField.cookbookDifficulty, 3),
    ],
  ).copyWith(id: 'cookbook4'),
].map((model) => MapEntry(model.id, model)));
