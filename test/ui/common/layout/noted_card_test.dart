import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Card', () {
    testWidgets('card renders as expected', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();
      const Key smallKey = Key('small');
      const Key mediumKey = Key('medium');
      const Key largeKey = Key('large');

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: NotedCard(
                  key: smallKey,
                  size: NotedWidgetSize.small,
                  onTap: onPressed,
                ),
              ),
              SizedBox(
                height: 80,
                child: NotedCard(
                  key: mediumKey,
                  size: NotedWidgetSize.medium,
                ),
              ),
              SizedBox(
                height: 80,
                child: NotedCard(
                  key: largeKey,
                  size: NotedWidgetSize.large,
                  onTap: onPressed,
                ),
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

      verify(() => onPressed()).called(2);
    });
  });
}
