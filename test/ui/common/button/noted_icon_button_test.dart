import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/common.dart';
import '../../test_wrapper.dart';

void main() {
  group('Noted Icon Button', () {
    testWidgets('simple icon button functions as expected', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();
      const Key smallKey = Key('small');
      const Key mediumKey = Key('medium');
      const Key largeKey = Key('large');

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              NotedIconButton(
                key: smallKey,
                icon: NotedIcons.h1,
                type: NotedIconButtonType.simple,
                size: NotedWidgetSize.small,
                onPressed: onPressed,
              ),
              NotedIconButton(
                key: mediumKey,
                icon: NotedIcons.h2,
                type: NotedIconButtonType.simple,
                onPressed: onPressed,
              ),
              NotedIconButton(
                key: largeKey,
                icon: NotedIcons.h3,
                type: NotedIconButtonType.simple,
                size: NotedWidgetSize.large,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      );

      Finder smallFinder = find.byKey(smallKey);
      Finder mediumFinder = find.byKey(mediumKey);
      Finder largeFinder = find.byKey(largeKey);

      expect(smallFinder, findsOneWidget);
      expect(mediumFinder, findsOneWidget);
      expect(largeFinder, findsOneWidget);

      expect(find.byIcon(NotedIcons.h1), findsOneWidget);
      expect(find.byIcon(NotedIcons.h2), findsOneWidget);
      expect(find.byIcon(NotedIcons.h3), findsOneWidget);

      expect(tester.getSize(smallFinder), equals(const Size.square(36)));
      expect(tester.getSize(mediumFinder), equals(const Size.square(44)));
      expect(tester.getSize(largeFinder), equals(const Size.square(54)));

      await tester.tap(smallFinder);
      await tester.tap(mediumFinder);
      await tester.tap(largeFinder);

      verify(onPressed()).called(3);
    });

    testWidgets('filled icon button functions as expected', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();
      const Key smallKey = Key('small');
      const Key mediumKey = Key('medium');
      const Key largeKey = Key('large');

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              NotedIconButton(
                key: smallKey,
                icon: NotedIcons.h1,
                type: NotedIconButtonType.filled,
                size: NotedWidgetSize.small,
                onPressed: onPressed,
              ),
              NotedIconButton(
                key: mediumKey,
                icon: NotedIcons.h2,
                type: NotedIconButtonType.filled,
                onPressed: onPressed,
              ),
              NotedIconButton(
                key: largeKey,
                icon: NotedIcons.h3,
                type: NotedIconButtonType.filled,
                size: NotedWidgetSize.large,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      );

      Finder smallFinder = find.byKey(smallKey);
      Finder mediumFinder = find.byKey(mediumKey);
      Finder largeFinder = find.byKey(largeKey);

      expect(smallFinder, findsOneWidget);
      expect(mediumFinder, findsOneWidget);
      expect(largeFinder, findsOneWidget);

      expect(find.byIcon(NotedIcons.h1), findsOneWidget);
      expect(find.byIcon(NotedIcons.h2), findsOneWidget);
      expect(find.byIcon(NotedIcons.h3), findsOneWidget);

      expect(tester.getSize(smallFinder), equals(const Size.square(44)));
      expect(tester.getSize(mediumFinder), equals(const Size.square(54)));
      expect(tester.getSize(largeFinder), equals(const Size.square(64)));

      await tester.tap(smallFinder);
      await tester.tap(mediumFinder);
      await tester.tap(largeFinder);

      verify(onPressed()).called(3);
    });
  });
}
