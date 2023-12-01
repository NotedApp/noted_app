import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Header Page', () {
    testWidgets('header page renders a header, back button, and content', (tester) async {
      MockVoidCallback trailing = MockVoidCallback();
      MockVoidCallback back = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: NotedHeaderPage(
            hasBackButton: true,
            onBack: back.call,
            title: 'test page title',
            trailingActions: [
              NotedIconButton(
                icon: NotedIcons.account,
                type: NotedIconButtonType.simple,
                onPressed: trailing.call,
              ),
            ],
            child: const Text('test page content'),
          ),
        ),
      );

      Finder action = find.byIcon(NotedIcons.account);
      Finder backButton = find.byIcon(NotedIcons.chevronLeft);

      await tester.tap(action);
      await tester.tap(backButton);

      expect(find.text('test page title'), findsOneWidget);
      expect(find.text('test page content'), findsOneWidget);
      expect(backButton, findsOneWidget);
      expect(action, findsOneWidget);

      verify(() => trailing()).called(1);
      verify(() => back()).called(1);
    });
  });
}
