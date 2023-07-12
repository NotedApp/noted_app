import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/common.dart';
import '../../test_wrapper.dart';

void main() {
  group('Noted Text Button', () {
    testWidgets('simple text button functions as expected', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              NotedTextButton(
                icon: NotedIcons.h1,
                label: 'simple small',
                type: NotedTextButtonType.simple,
                size: NotedWidgetSize.small,
                onPressed: onPressed,
              ),
              NotedTextButton(
                label: 'simple medium',
                type: NotedTextButtonType.simple,
                onPressed: onPressed,
              ),
              NotedTextButton(
                label: 'simple large',
                type: NotedTextButtonType.simple,
                size: NotedWidgetSize.large,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      );

      Finder smallFinder = find.text('simple small');
      Finder mediumFinder = find.text('simple medium');
      Finder largeFinder = find.text('simple large');

      expect(smallFinder, findsOneWidget);
      expect(mediumFinder, findsOneWidget);
      expect(largeFinder, findsOneWidget);
      expect(find.byIcon(NotedIcons.h1), findsOneWidget);

      await tester.tap(smallFinder);
      await tester.tap(mediumFinder);
      await tester.tap(largeFinder);

      verify(() => onPressed()).called(3);
    });

    testWidgets('filled text button functions as expected', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              NotedTextButton(
                label: 'filled small',
                type: NotedTextButtonType.filled,
                size: NotedWidgetSize.small,
                onPressed: onPressed,
              ),
              NotedTextButton(
                icon: NotedIcons.h2,
                label: 'filled medium',
                type: NotedTextButtonType.filled,
                onPressed: onPressed,
              ),
              NotedTextButton(
                label: 'filled large',
                type: NotedTextButtonType.filled,
                size: NotedWidgetSize.large,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      );

      Finder smallFinder = find.text('filled small');
      Finder mediumFinder = find.text('filled medium');
      Finder largeFinder = find.text('filled large');

      expect(smallFinder, findsOneWidget);
      expect(mediumFinder, findsOneWidget);
      expect(largeFinder, findsOneWidget);
      expect(find.byIcon(NotedIcons.h2), findsOneWidget);

      await tester.tap(smallFinder);
      await tester.tap(mediumFinder);
      await tester.tap(largeFinder);

      verify(() => onPressed()).called(3);
    });

    testWidgets('outlined text button functions as expected', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              NotedTextButton(
                label: 'outlined small',
                type: NotedTextButtonType.outlined,
                size: NotedWidgetSize.small,
                onPressed: onPressed,
              ),
              NotedTextButton(
                label: 'outlined medium',
                type: NotedTextButtonType.outlined,
                onPressed: onPressed,
              ),
              NotedTextButton(
                icon: NotedIcons.h3,
                label: 'outlined large',
                type: NotedTextButtonType.outlined,
                size: NotedWidgetSize.large,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      );

      Finder smallFinder = find.text('outlined small');
      Finder mediumFinder = find.text('outlined medium');
      Finder largeFinder = find.text('outlined large');

      expect(smallFinder, findsOneWidget);
      expect(mediumFinder, findsOneWidget);
      expect(largeFinder, findsOneWidget);
      expect(find.byIcon(NotedIcons.h3), findsOneWidget);

      await tester.tap(smallFinder);
      await tester.tap(mediumFinder);
      await tester.tap(largeFinder);

      verify(() => onPressed()).called(3);
    });
  });
}
