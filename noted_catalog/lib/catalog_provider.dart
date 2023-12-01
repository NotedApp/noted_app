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

final DocumentModel _mockDelta0 = [
  {'insert': 'hello world\n'},
];

class _MockNotesBloc extends Mock implements NotesBloc {}

final List<NoteModel> _testNotes = [
  const NotebookNoteModel(
    id: 'notebook0',
    title: '',
    document: DocumentUtil.emptyDocument,
  ),
  const NotebookNoteModel(
    id: 'notebook1',
    title: 'test note',
    document: DocumentUtil.emptyDocument,
  ),
  NotebookNoteModel(
    id: 'notebook2',
    title: 'test note',
    document: _mockDelta0,
  ),
  NotebookNoteModel(
    id: 'notebook3',
    title: '',
    document: _mockDelta0,
    tagIds: {'0'},
  ),
  NotebookNoteModel(
    id: 'notebook4',
    title: 'test note',
    document: _mockDelta0,
    tagIds: {'0'},
  ),
  CookbookNoteModel(
    id: 'cookbook0',
    title: 'empty recipe',
    url: '',
    prepTime: '',
    cookTime: '',
    difficulty: 3,
    document: _mockDelta0,
  ),
  CookbookNoteModel(
    id: 'cookbook1',
    title: 'a recipe with a super duper long title',
    url: '',
    prepTime: '15m',
    cookTime: '30m',
    difficulty: 3,
    document: _mockDelta0,
    tagIds: {'0'},
  ),
  CookbookNoteModel(
    id: 'cookbook2',
    title: 'a recipe with a super duper long title',
    url: 'nceuponachef.com/rec',
    prepTime: '',
    cookTime: '30m',
    difficulty: 3,
    document: _mockDelta0,
  ),
  const CookbookNoteModel(
    id: 'cookbook3',
    title: 'a recipe with a super duper long title',
    url: 'https://www.onceuponachef.com/recipes/roasted-brussels-sprouts.html',
    prepTime: '',
    cookTime: '30m',
    difficulty: 3,
    document: DocumentUtil.emptyDocument,
  ),
  const CookbookNoteModel(
    id: 'cookbook4',
    title: 'miso salmon',
    url: 'https://www.justonecookbook.com/miso-salmon/',
    prepTime: '1hr',
    cookTime: '15m',
    difficulty: 3,
    document: DocumentUtil.emptyDocument,
    tagIds: {'0'},
  ),
];
