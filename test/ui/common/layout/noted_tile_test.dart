import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/plugins/cookbook/cookbook_tile.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_tile.dart';
import 'package:noted_models/noted_models.dart';

import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
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
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 150,
                child: NotedTile.buildTile(
                  note: NotebookNoteModel(
                    id: 'notebook',
                    title: 'notebook',
                    document: [
                      {'insert': '\n'},
                    ],
                  ),
                  onPressed: notebookCallback,
                ),
              ),
              SizedBox(
                width: 300,
                height: 150,
                child: NotedTile.buildTile(
                  note: CookbookNoteModel(
                    id: 'notebook',
                    title: 'notebook',
                    url: '',
                    prepTime: '',
                    cookTime: '',
                    difficulty: 3,
                    document: [
                      {'insert': '\n'},
                    ],
                  ),
                  onPressed: cookbookCallback,
                ),
              ),
              SizedBox(
                width: 300,
                height: 150,
                child: NotedTile.buildTile(
                  note: CookbookNoteModel(
                    id: 'notebook',
                    title: '',
                    url: '',
                    prepTime: '',
                    cookTime: '',
                    difficulty: 3,
                    document: [
                      {'insert': '\n'},
                    ],
                  ),
                  onPressed: cookbookCallback,
                ),
              ),
            ],
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
