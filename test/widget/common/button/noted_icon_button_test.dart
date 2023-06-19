import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:noted_app/widget/common/noted_library.dart';

import '../../../mocks/common.dart';

void main() {
  group('Noted Icon Button', () {
    testWidgets('simple icon button functions as expected', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();
      const Key smallKey = Key('small');
      const Key mediumKey = Key('medium');
      const Key largeKey = Key('large');

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
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

      expect(tester.getSize(smallFinder), equals(const Size(36, 36)));
      expect(tester.getSize(mediumFinder), equals(const Size(44, 44)));
      expect(tester.getSize(largeFinder), equals(const Size(54, 54)));

      await tester.tap(smallFinder);
      await tester.tap(mediumFinder);
      await tester.tap(largeFinder);

      verify(onPressed()).called(3);
    });
  });
}
