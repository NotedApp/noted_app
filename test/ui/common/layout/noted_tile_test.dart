import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/plugins/notebook/tiles/notebook_note_tile.dart';
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
              onTap: onPressed,
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

    testWidgets('loading tile renders as expected', (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: SizedBox(
            height: 80,
            child: NotedLoadingTile(),
          ),
        ),
      );
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('tile builder works as expected', (tester) async {
      MockVoidCallback notebookCallback = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: buildNotedTile(
                  NotebookNote(
                    id: 'notebook',
                    title: 'notebook',
                    document: [
                      {'insert': '\n'},
                    ],
                  ),
                  notebookCallback,
                ),
              )
            ],
          ),
        ),
      );

      Finder notebookFinder = find.byType(NotebookNoteTile);

      await tester.tap(notebookFinder);

      expect(notebookFinder, findsOneWidget);
      verify(() => notebookCallback()).called(1);
    });
  });
}
