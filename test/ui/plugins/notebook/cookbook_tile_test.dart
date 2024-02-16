import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/repository/ogp/local_ogp_repository.dart';
import 'package:noted_app/repository/ogp/ogp_repository.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/environment/environment.dart';

import '../../../helpers/environment/unit_test_environment.dart';
import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Cookbook Tile', () {
    setUpAll(() {
      UnitTestEnvironment().configure();
      (locator<OgpRepository>() as LocalOgpRepository).msDelay = 0;
    });

    testWidgets('tile without url renders as expected', (tester) async {
      MockVoidCallback callback = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: NotedTile(
                  noteId: 'cookbook0',
                  onPressed: callback.call,
                ),
              )
            ],
          ),
        ),
      );

      Finder titleFinder = find.text('cookbook');
      Finder prepTimeFinder = find.text('prep time: 1hr');
      Finder cookTimeFinder = find.text('cook time: 15m');
      Finder tagsFinder = find.byType(NotedTagRow);
      Finder bodyFinder = find.byType(QuillEditor);

      await tester.tap(titleFinder);
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(prepTimeFinder, findsOneWidget);
      expect(cookTimeFinder, findsOneWidget);
      expect(tagsFinder, findsOneWidget);
      expect(bodyFinder, findsOneWidget);
      verify(() => callback()).called(1);
    });

    testWidgets('tile with url renders as expected', (tester) async {
      MockVoidCallback callback = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: NotedTile(
                  noteId: 'cookbook1',
                  onPressed: callback.call,
                ),
              ),
            ],
          ),
        ),
      );

      Finder titleFinder = find.text('cookbook');
      Finder prepTimeFinder = find.text('prep time: 1hr');
      Finder cookTimeFinder = find.text('cook time: 15m');
      Finder tagsFinder = find.byType(NotedTagRow);
      Finder linkFinder = find.byType(NotedLink);
      Finder bodyFinder = find.byType(QuillEditor);

      await tester.tap(titleFinder);
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(prepTimeFinder, findsOneWidget);
      expect(cookTimeFinder, findsOneWidget);
      expect(tagsFinder, findsOneWidget);
      expect(linkFinder, findsOneWidget);
      expect(bodyFinder, findsNothing);
      verify(() => callback()).called(1);
    });
  });
}
