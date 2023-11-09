import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/plugins/cookbook/cookbook_tile.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_tile.dart';
import 'package:noted_models/noted_models.dart';

import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/mocks/mock_classes.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  final MockNotesBloc notesBloc = MockNotesBloc();
  final List<NoteModel> notes = [
    NotebookNoteModel(
      id: 'notebook',
      title: 'notebook',
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

  setUp(() {
    when(() => notesBloc.state).thenAnswer((_) => NotesState.success(notes: notes));
    when(() => notesBloc.stream).thenAnswer((_) => Stream.value(NotesState.success(notes: notes)));
  });

  group('Noted Tile', () {
    testWidgets('tile renders as expected', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: SizedBox(
            height: 80,
            child: NotedTile(
              child: Text('noted tile'),
              onPressed: onPressed,
            ),
          ),
        ),
      );

      Finder cardFinder = find.byType(Card);
      Card card = tester.widget<Card>(cardFinder.at(0));

      await tester.tap(cardFinder);

      expect(cardFinder, findsOneWidget);
      expect((card.shape! as RoundedRectangleBorder).borderRadius, equals(BorderRadius.circular(12)));
      verify(() => onPressed()).called(1);
    });

    testWidgets('tile with tags renders as expected', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: SizedBox(
            height: 80,
            child: NotedTile(
              child: Text('noted tile'),
              tags: {'0'},
              onPressed: onPressed,
            ),
          ),
        ),
      );

      Finder tagFinder = find.byType(NotedTag);
      expect(tagFinder, findsNWidgets(4));
    });

    testWidgets('tile builder works as expected', (tester) async {
      MockVoidCallback notebookCallback = MockVoidCallback();
      MockVoidCallback cookbookCallback = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: BlocProvider<NotesBloc>.value(
            value: notesBloc,
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  height: 150,
                  child: NotedTileBuilder(
                    noteId: 'notebook',
                    onPressed: notebookCallback,
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 150,
                  child: NotedTileBuilder(
                    noteId: 'cookbook0',
                    onPressed: cookbookCallback,
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 150,
                  child: NotedTileBuilder(
                    noteId: 'cookbook1',
                    onPressed: cookbookCallback,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      Finder notebookFinder = find.byType(NotebookTile);
      Finder cookbookFinder = find.byType(CookbookTile);

      await tester.tap(notebookFinder);
      await tester.tap(cookbookFinder.first);

      expect(notebookFinder, findsOneWidget);
      expect(cookbookFinder, findsNWidgets(2));
      verify(() => notebookCallback()).called(1);
      verify(() => cookbookCallback()).called(1);
    });
  });
}
