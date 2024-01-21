import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Search Bar Field', () {
    testWidgets('search bar types and resets', (tester) async {
      final controller = TextEditingController();
      final onCancel = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: NotedSearchBar(
            controller: controller,
            onCancel: onCancel.call,
          ),
        ),
      );

      Finder input = find.byType(NotedTextField);
      Finder search = find.byIcon(NotedIcons.search);
      Finder close = find.byIcon(NotedIcons.close);

      expect(input, findsOneWidget);
      expect(search, findsOneWidget);

      await tester.enterText(input, 'test');
      await tester.pumpAndSettle();
      expect(close, findsOneWidget);

      await tester.tap(close);
      await tester.pumpAndSettle();
      expect(search, findsOneWidget);
      verify(onCancel.call).called(1);

      controller.dispose();
    });
  });
}
