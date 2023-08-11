import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/environment/unit_test_environment.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted String Picker', () {
    setUpAll(() {
      UnitTestEnvironment().configure();
    });

    testWidgets('string picker selects a string', (tester) async {
      Future<String?> result = Future.value('');

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => NotedIconButton(
              icon: NotedIcons.link,
              type: NotedIconButtonType.simple,
              onPressed: () {
                result = showStringPicker(context, '', title: 'title');
              },
            ),
          ),
        ),
      );

      Finder button = find.byIcon(NotedIcons.link);
      await tester.tap(button);
      await tester.pump(const Duration(seconds: 1));

      Finder input = find.byType(NotedTextField);

      expect(input, findsOneWidget);
      await tester.enterText(input, 'test');

      Finder confirm = find.text('confirm');

      await tester.tap(confirm);
      await tester.pump(const Duration(seconds: 1));

      expect(result, completion(equals('test')));
    });

    testWidgets('string picker cancels selecting a color', (tester) async {
      Future<String?> result = Future.value('');

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => NotedIconButton(
              icon: NotedIcons.link,
              type: NotedIconButtonType.simple,
              onPressed: () {
                result = showStringPicker(context, '', title: 'title');
              },
            ),
          ),
        ),
      );

      Finder button = find.byIcon(NotedIcons.link);
      await tester.tap(button);
      await tester.pump(const Duration(seconds: 1));

      Finder input = find.byType(NotedTextField);

      expect(input, findsOneWidget);
      await tester.enterText(input, 'test');

      Finder cancel = find.text('cancel');

      await tester.tap(cancel);
      await tester.pump(const Duration(seconds: 1));

      expect(result, completion(equals(null)));
    });
  });
}
