import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_tile.dart';
import 'package:noted_models/noted_models.dart';

import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Notebook Tile', () {
    testWidgets('tile with title renders as expected', (tester) async {
      MockVoidCallback callback = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: NotebookTile(
                  note: NotebookNoteModel(
                    id: 'notebook',
                    title: 'notebook',
                    document: [
                      {'insert': '\n'},
                    ],
                  ),
                  onTap: callback,
                ),
              )
            ],
          ),
        ),
      );

      Finder titleFinder = find.text('notebook');
      Finder bodyFinder = find.byType(QuillEditor);

      await tester.tap(titleFinder);

      expect(titleFinder, findsOneWidget);
      expect(bodyFinder, findsOneWidget);
      verify(() => callback()).called(1);
    });

    testWidgets('tile without title renders as expected', (tester) async {
      MockVoidCallback callback = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: NotebookTile(
                  note: NotebookNoteModel(
                    id: 'notebook',
                    title: '',
                    document: [
                      {'insert': '\n'},
                    ],
                  ),
                  onTap: callback,
                ),
              )
            ],
          ),
        ),
      );

      Finder bodyFinder = find.byType(QuillEditor);

      await tester.tap(bodyFinder);

      expect(bodyFinder, findsOneWidget);
      expect(find.byType(Text), findsNothing);
      verify(() => callback()).called(1);
    });
  });
}
