import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:noted_app/widget/common/noted_library.dart';

import '../../../helpers/common.dart';
import '../../test_wrapper.dart';

void main() {
  group('Noted Card', () {
    testWidgets('simple icon button functions as expected', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();
      const Key smallKey = Key('small');
      const Key mediumKey = Key('medium');
      const Key largeKey = Key('large');

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              NotedCard(
                key: smallKey,
                height: 80,
                width: 80,
                size: NotedWidgetSize.small,
                onTap: onPressed,
              ),
              NotedCard(
                key: mediumKey,
                height: 80,
                width: 80,
                size: NotedWidgetSize.medium,
              ),
              NotedCard(
                key: largeKey,
                height: 80,
                width: 80,
                size: NotedWidgetSize.large,
                onTap: onPressed,
              ),
            ],
          ),
        ),
      );

      Finder smallFinder = find.byKey(smallKey);
      Finder mediumFinder = find.byKey(mediumKey);
      Finder largeFinder = find.byKey(largeKey);
      Finder cardFinder = find.byType(Card);

      expect(smallFinder, findsOneWidget);
      expect(mediumFinder, findsOneWidget);
      expect(largeFinder, findsOneWidget);

      Card small = tester.widget<Card>(cardFinder.at(0));
      Card medium = tester.widget<Card>(cardFinder.at(1));
      Card large = tester.widget<Card>(cardFinder.at(2));

      expect((small.shape! as RoundedRectangleBorder).borderRadius, equals(BorderRadius.circular(12)));
      expect((medium.shape! as RoundedRectangleBorder).borderRadius, equals(BorderRadius.circular(16)));
      expect((large.shape! as RoundedRectangleBorder).borderRadius, equals(BorderRadius.circular(24)));

      await tester.tap(smallFinder);
      await tester.tap(mediumFinder);
      await tester.tap(largeFinder);

      verify(onPressed()).called(2);
    });
  });
}
