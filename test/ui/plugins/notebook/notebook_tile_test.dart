import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';

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
                child: NotedTile(
                  noteId: 'notebook0',
                  onPressed: callback,
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
                child: NotedTile(
                  noteId: 'notebook1',
                  onPressed: callback,
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
