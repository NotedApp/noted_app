import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_models/noted_models.dart';
import 'package:noted_models/notes/notes.dart';

import 'mocks/mock_classes.dart';

final Map<String, NoteModel> testNotes = Map.fromEntries([
  noteTemplate.copyWith(id: 'note0').updateField<String>(CommonField.title, 'note'),
  noteTemplate.copyWith(id: 'note1').updateField<String>(CommonField.title, ''),
  noteTemplate.copyWith(id: 'note2', defaultFields: const NoteDefaultFields(hidden: true)),
  recipeTemplate
      .copyWith(id: 'recipe0')
      .updateField<String>(CommonField.title, 'recipe')
      .updateField<Duration>(RecipeField.prepTime, const Duration(hours: 1))
      .updateField<Duration>(RecipeField.cookTime, const Duration(minutes: 15)),
  recipeTemplate
      .copyWith(id: 'recipe1')
      .updateField<String>(CommonField.title, 'recipe')
      .updateField<String>(CommonField.link, 'https://www.onceuponachef.com/recipes/roasted-brussels-sprouts.html')
      .updateField<Duration>(RecipeField.prepTime, const Duration(hours: 1))
      .updateField<Duration>(RecipeField.cookTime, const Duration(minutes: 15)),
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
