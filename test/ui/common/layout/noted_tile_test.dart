import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/repository/ogp/local_ogp_repository.dart';
import 'package:noted_app/repository/ogp/ogp_repository.dart';
import 'package:noted_app/ui/common/noted_library.dart';
// import 'package:noted_app/ui/plugins/cookbook/cookbook_tile_content.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_tile_content.dart';
import 'package:noted_app/util/environment/environment.dart';

import '../../../helpers/environment/unit_test_environment.dart';
import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

// TODO: Uncomment tests once merged with #175.

void main() {
  group('Noted Tile', () {
    setUpAll(() {
      UnitTestEnvironment().configure();
      (locator<OgpRepository>() as LocalOgpRepository).msDelay = 0;
    });

    testWidgets('empty tile renders as expected', (tester) async {
      MockVoidCallback notebookCallback = MockVoidCallback();
      const double width = 300;
      const double height = 300 / NotedWidgetConfig.tileAspectRatio;

      await tester.pumpWidget(
        TestWrapper(
          child: SizedBox(
            width: width,
            height: height,
            child: NotedTile(
              noteId: 'notebook2',
              onPressed: notebookCallback.call,
            ),
          ),
        ),
      );

      Finder titleFinder = find.byType(Text);
      Finder noteFinder = find.byType(NotedTile);
      Finder editorFinder = find.byType(NotedEditor);

      await tester.tap(noteFinder);

      expect(titleFinder, findsOneWidget);
      expect(editorFinder, findsNothing);
      verify(() => notebookCallback()).called(1);
    });

    testWidgets('tile builder works as expected', (tester) async {
      tester.view.physicalSize = const Size(300, 2000);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      MockVoidCallback notebookCallback = MockVoidCallback();
      // MockVoidCallback cookbookCallback = MockVoidCallback();
      MockVoidCallback climbingCallback = MockVoidCallback();

      const double width = 300;
      const double height = 300 / NotedWidgetConfig.tileAspectRatio;

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              SizedBox(
                width: width,
                height: height,
                child: NotedTile(
                  noteId: 'notebook0',
                  onPressed: notebookCallback.call,
                ),
              ),
              // SizedBox(
              //   width: width,
              //   height: height,
              //   child: NotedTile(
              //     noteId: 'cookbook0',
              //     onPressed: cookbookCallback.call,
              //   ),
              // ),
              // SizedBox(
              //   width: width,
              //   height: height,
              //   child: NotedTile(
              //     noteId: 'cookbook1',
              //     onPressed: cookbookCallback.call,
              //   ),
              // ),
              SizedBox(
                width: width,
                height: height,
                child: NotedTile(
                  noteId: 'climbing0',
                  onPressed: climbingCallback.call,
                ),
              ),
            ],
          ),
        ),
      );

      Finder notebookFinder = find.byType(NotebookTileContent);
      // Finder cookbookFinder = find.byType(CookbookTileContent);
      Finder climbingFinder = find.byType(CircularProgressIndicator);

      await tester.tap(notebookFinder);
      // await tester.tap(cookbookFinder.first);
      await tester.tap(climbingFinder);

      expect(notebookFinder, findsOneWidget);
      // expect(cookbookFinder, findsNWidgets(2));
      expect(notebookFinder, findsOneWidget);
      verify(() => notebookCallback()).called(1);
      // verify(() => cookbookCallback()).called(1);
      verify(() => climbingCallback()).called(1);
    });
  });
}
