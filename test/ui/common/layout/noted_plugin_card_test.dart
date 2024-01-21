import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_models/noted_models.dart';

import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Plugin Card', () {
    testWidgets('plugin card renders as expected', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();
      const Key smallKey = Key('small');
      const Key mediumKey = Key('medium');
      const Key largeKey = Key('large');

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              NotedPluginCard(
                plugin: NotedPlugin.notebook,
                size: NotedWidgetSize.small,
                onPressed: onPressed.call,
                key: smallKey,
              ),
              const NotedPluginCard(
                plugin: NotedPlugin.cookbook,
                key: mediumKey,
              ),
              NotedPluginCard(
                plugin: NotedPlugin.notebook,
                size: NotedWidgetSize.large,
                onPressed: onPressed.call,
                key: largeKey,
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

      await tester.tap(smallFinder);
      await tester.tap(mediumFinder);
      await tester.tap(largeFinder);

      verify(() => onPressed()).called(2);
    });
  });
}
