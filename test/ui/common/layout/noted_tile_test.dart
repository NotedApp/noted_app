import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/common.dart';
import '../../test_wrapper.dart';

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
  });
}
