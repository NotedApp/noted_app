import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_models/noted_models.dart';

import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Tag', () {
    testWidgets('tags function as expected', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              NotedTag(
                model: TagModel(
                  id: 'small',
                  name: 'small',
                  color: 0xFFFFFFFF,
                ),
                size: NotedWidgetSize.small,
                onPressed: onPressed,
              ),
              NotedTag.add(
                size: NotedWidgetSize.medium,
                onPressed: onPressed,
              ),
              NotedTag.delete(
                model: TagModel(
                  id: 'large',
                  name: 'large',
                  color: 0xFFFFFFFF,
                ),
                size: NotedWidgetSize.large,
                onPressed: onPressed,
              ),
              NotedTag.custom(
                text: 'custom',
                color: Colors.red.shade500,
                size: NotedWidgetSize.large,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      );

      Finder smallFinder = find.text('small');
      Finder mediumFinder = find.text('tag');
      Finder largeFinder = find.text('large');
      Finder customFinder = find.text('custom');

      expect(smallFinder, findsOneWidget);
      expect(mediumFinder, findsOneWidget);
      expect(largeFinder, findsOneWidget);
      expect(customFinder, findsOneWidget);

      expect(find.byIcon(NotedIcons.plus), findsOneWidget);
      expect(find.byIcon(NotedIcons.trash), findsOneWidget);

      await tester.tap(smallFinder);
      await tester.tap(mediumFinder);
      await tester.tap(largeFinder);
      await tester.tap(customFinder);

      verify(() => onPressed()).called(4);
    });
  });
}
