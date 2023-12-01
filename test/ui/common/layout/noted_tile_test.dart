import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/plugins/cookbook/cookbook_tile_content.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_tile_content.dart';

import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Tile', () {
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
                child: NotedTile(
                  noteId: 'notebook0',
                  onPressed: notebookCallback.call,
                ),
              ),
              SizedBox(
                width: 300,
                height: 150,
                child: NotedTile(
                  noteId: 'cookbook0',
                  onPressed: cookbookCallback.call,
                ),
              ),
              SizedBox(
                width: 300,
                height: 150,
                child: NotedTile(
                  noteId: 'cookbook1',
                  onPressed: cookbookCallback.call,
                ),
              ),
            ],
          ),
        ),
      );

      Finder notebookFinder = find.byType(NotebookTileContent);
      Finder cookbookFinder = find.byType(CookbookTileContent);

      await tester.tap(notebookFinder);
      await tester.tap(cookbookFinder.first);

      expect(notebookFinder, findsOneWidget);
      expect(cookbookFinder, findsNWidgets(2));
      verify(() => notebookCallback()).called(1);
      verify(() => cookbookCallback()).called(1);
    });
  });
}
