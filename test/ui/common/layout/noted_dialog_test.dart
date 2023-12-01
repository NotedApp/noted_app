import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Dialog', () {
    testWidgets('dialog renders title, body, and actions which register events', (tester) async {
      tester.view.physicalSize = const Size(600, 1200);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      MockVoidCallback onLeft = MockVoidCallback();
      MockVoidCallback onRight = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => NotedIconButton(
              icon: NotedIcons.pencil,
              type: NotedIconButtonType.simple,
              onPressed: () => showDialog(
                context: context,
                builder: (context) => NotedDialog(
                  title: 'test dialog title',
                  leftActionText: 'test left',
                  onLeftActionPressed: onLeft.call,
                  rightActionText: 'test right',
                  onRightActionPressed: onRight.call,
                  child: const Text('test dialog content'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(NotedIcons.pencil));
      await tester.pump(const Duration(seconds: 1));

      Finder left = find.text('test left');
      Finder right = find.text('test right');

      expect(find.text('test dialog title'), findsOneWidget);
      expect(find.text('test dialog content'), findsOneWidget);
      expect(left, findsOneWidget);
      expect(right, findsOneWidget);

      await tester.tap(left);
      await tester.tap(right);
      await tester.pump(const Duration(seconds: 1));

      verify(() => onLeft()).called(1);
      verify(() => onRight()).called(1);
    });

    testWidgets('dialog handles only left action', (tester) async {
      tester.view.physicalSize = const Size(600, 1200);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      MockVoidCallback onLeft = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => NotedIconButton(
              icon: NotedIcons.pencil,
              type: NotedIconButtonType.simple,
              onPressed: () => showDialog(
                context: context,
                builder: (context) => NotedDialog(
                  title: 'test dialog title',
                  leftActionText: 'test left',
                  onLeftActionPressed: onLeft.call,
                  child: const Text('test dialog content'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(NotedIcons.pencil));
      await tester.pump(const Duration(seconds: 1));

      Finder left = find.text('test left');
      Finder right = find.text('test right');

      expect(find.text('test dialog title'), findsOneWidget);
      expect(find.text('test dialog content'), findsOneWidget);
      expect(left, findsOneWidget);
      expect(right, findsNothing);

      await tester.tap(left);
      await tester.pump(const Duration(seconds: 1));

      verify(() => onLeft()).called(1);
    });

    testWidgets('dialog handles only right action', (tester) async {
      tester.view.physicalSize = const Size(600, 1200);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      MockVoidCallback onRight = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => NotedIconButton(
              icon: NotedIcons.pencil,
              type: NotedIconButtonType.simple,
              onPressed: () => showDialog(
                context: context,
                builder: (context) => NotedDialog(
                  title: 'test dialog title',
                  rightActionText: 'test right',
                  onRightActionPressed: onRight.call,
                  child: const Text('test dialog content'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(NotedIcons.pencil));
      await tester.pump(const Duration(seconds: 1));

      Finder left = find.text('test left');
      Finder right = find.text('test right');

      expect(find.text('test dialog title'), findsOneWidget);
      expect(find.text('test dialog content'), findsOneWidget);
      expect(left, findsNothing);
      expect(right, findsOneWidget);

      await tester.tap(right);
      await tester.pump(const Duration(seconds: 1));

      verify(() => onRight()).called(1);
    });
  });
}
