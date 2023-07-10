import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/common.dart';
import '../../test_wrapper.dart';

void main() {
  group('Noted Header', () {
    testWidgets('header renders a title, leading action, and trailing action', (tester) async {
      MockVoidCallback leading = MockVoidCallback();
      MockVoidCallback trailing = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => NotedHeader(
              context: context,
              leadingAction: NotedIconButton(
                icon: NotedIcons.chevronLeft,
                type: NotedIconButtonType.simple,
                onPressed: leading,
              ),
              title: 'test page title',
              trailingActions: [
                NotedIconButton(
                  icon: NotedIcons.account,
                  type: NotedIconButtonType.simple,
                  onPressed: trailing,
                ),
              ],
            ),
          ),
        ),
      );

      Finder leadingButton = find.byIcon(NotedIcons.chevronLeft);
      Finder trailingButton = find.byIcon(NotedIcons.account);

      await tester.tap(leadingButton);
      await tester.tap(trailingButton);

      expect(find.text('test page title'), findsOneWidget);
      expect(leadingButton, findsOneWidget);
      expect(trailingButton, findsOneWidget);

      verify(leading()).called(1);
      verify(trailing()).called(1);
    });

    testWidgets('header handles a case with no title', (tester) async {
      MockVoidCallback leading = MockVoidCallback();
      MockVoidCallback trailing = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => NotedHeader(
              context: context,
              leadingAction: NotedIconButton(
                icon: NotedIcons.chevronLeft,
                type: NotedIconButtonType.simple,
                onPressed: leading,
              ),
              trailingActions: [
                NotedIconButton(
                  icon: NotedIcons.account,
                  type: NotedIconButtonType.simple,
                  onPressed: trailing,
                ),
              ],
            ),
          ),
        ),
      );

      Finder leadingButton = find.byIcon(NotedIcons.chevronLeft);
      Finder trailingButton = find.byIcon(NotedIcons.account);

      await tester.tap(leadingButton);
      await tester.tap(trailingButton);

      expect(find.text('test page title'), findsNothing);
      expect(leadingButton, findsOneWidget);
      expect(trailingButton, findsOneWidget);

      verify(leading()).called(1);
      verify(trailing()).called(1);
    });
  });
}
