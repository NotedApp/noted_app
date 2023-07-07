import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:noted_app/widget/common/noted_library.dart';

import '../../../helpers/common.dart';
import '../../test_wrapper.dart';

void main() {
  group('Noted Snack Bar', () {
    testWidgets('snack bar is created with simple content', (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: Scaffold(
            body: Builder(
              builder: (context) => NotedIconButton(
                icon: NotedIcons.pencil,
                type: NotedIconButtonType.simple,
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  NotedSnackBar.create(
                    context: context,
                    content: Text('test snackbar content'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(NotedIcons.pencil));
      await tester.pump(const Duration(seconds: 1));

      SnackBar bar = tester.widget(find.byType(SnackBar));

      expect(find.text('test snackbar content'), findsOneWidget);
      expect((bar.shape! as RoundedRectangleBorder).borderRadius, equals(BorderRadius.circular(12)));
    });

    testWidgets('snack bar is created with text content', (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: Scaffold(
            body: Builder(
              builder: (context) => NotedIconButton(
                icon: NotedIcons.pencil,
                type: NotedIconButtonType.simple,
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  NotedSnackBar.createWithText(
                    context: context,
                    text: 'test snackbar content',
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(NotedIcons.pencil));
      await tester.pump(const Duration(seconds: 1));

      SnackBar bar = tester.widget(find.byType(SnackBar));

      expect(find.text('test snackbar content'), findsOneWidget);
      expect((bar.shape! as RoundedRectangleBorder).borderRadius, equals(BorderRadius.circular(12)));
    });

    testWidgets('snack bar is created with text and close content', (tester) async {
      MockVoidCallback close = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Scaffold(
            body: Builder(
              builder: (context) => NotedIconButton(
                icon: NotedIcons.pencil,
                type: NotedIconButtonType.simple,
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  NotedSnackBar.createWithText(
                    context: context,
                    text: 'test snackbar content',
                    hasClose: true,
                    onClose: close,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(NotedIcons.pencil));
      await tester.pump(const Duration(seconds: 1));

      Finder closeButton = find.byIcon(NotedIcons.close);
      SnackBar bar = tester.widget(find.byType(SnackBar));

      expect(find.text('test snackbar content'), findsOneWidget);
      expect(closeButton, findsOneWidget);
      expect((bar.shape! as RoundedRectangleBorder).borderRadius, equals(BorderRadius.circular(12)));

      await tester.tap(find.byIcon(NotedIcons.close));
      await tester.pump(const Duration(seconds: 1));

      verify(close()).called(1);
    });

    testWidgets('snack bar is created with text and default close content', (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: Scaffold(
            body: Builder(
              builder: (context) => NotedIconButton(
                icon: NotedIcons.pencil,
                type: NotedIconButtonType.simple,
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  NotedSnackBar.createWithText(
                    context: context,
                    text: 'test snackbar content',
                    hasClose: true,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(NotedIcons.pencil));
      await tester.pump(const Duration(seconds: 1));

      Finder closeButton = find.byIcon(NotedIcons.close);
      SnackBar bar = tester.widget(find.byType(SnackBar));

      expect(find.text('test snackbar content'), findsOneWidget);
      expect(closeButton, findsOneWidget);
      expect((bar.shape! as RoundedRectangleBorder).borderRadius, equals(BorderRadius.circular(12)));

      await tester.tap(find.byIcon(NotedIcons.close));
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('test snackbar content'), findsNothing);
    });
  });
}
