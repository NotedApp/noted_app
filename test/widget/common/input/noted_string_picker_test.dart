import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/widget/common/noted_library.dart';

import '../../test_wrapper.dart';

void main() {
  group('Noted String Picker', () {
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

      Finder confirm = find.byWidgetPredicate(
        (widget) => widget is NotedTextButton && widget.type == NotedTextButtonType.simple,
      );

      await tester.tap(confirm.first);
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

      Finder cancel = find.byWidgetPredicate(
        (widget) => widget is NotedTextButton && widget.type == NotedTextButtonType.simple,
      );

      await tester.tap(cancel.last);
      await tester.pump(const Duration(seconds: 1));

      expect(result, completion(equals(null)));
    });
  });
}
