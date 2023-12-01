import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/environment/unit_test_environment.dart';
import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Color Picker', () {
    setUpAll(() {
      UnitTestEnvironment().configure();
    });

    testWidgets('color picker renders all colors and resets default', (tester) async {
      tester.view.physicalSize = const Size(600, 1200);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      MockVoidCallback onReset = MockVoidCallback();
      Future<Color?> result = Future.value(Colors.black);

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => NotedIconButton(
              icon: NotedIcons.eyedropper,
              type: NotedIconButtonType.simple,
              onPressed: () {
                result = showColorPicker(context, Colors.black, onReset.call);
              },
            ),
          ),
        ),
      );

      Finder button = find.byIcon(NotedIcons.eyedropper);
      await tester.tap(button);
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(NotedColorPickerButton), findsNWidgets(20));

      Finder reset = find.byWidgetPredicate(
        (widget) => widget is NotedTextButton && widget.type == NotedTextButtonType.outlined,
      );

      expect(reset, findsOneWidget);

      await tester.tap(reset);
      await tester.pump(const Duration(seconds: 1));

      expect(result, completion(equals(null)));
      verify(() => onReset()).called(1);
    });

    testWidgets('color picker selects a color', (tester) async {
      tester.view.physicalSize = const Size(600, 1200);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      Future<Color?> result = Future.value(Colors.black);

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => NotedIconButton(
              icon: NotedIcons.eyedropper,
              type: NotedIconButtonType.simple,
              onPressed: () {
                result = showColorPicker(context, Colors.black, null);
              },
            ),
          ),
        ),
      );

      Finder button = find.byIcon(NotedIcons.eyedropper);
      await tester.tap(button);
      await tester.pump(const Duration(seconds: 1));

      Finder color = find.byWidgetPredicate(
        (widget) => widget is NotedColorPickerButton && widget.color == Colors.blueGrey.shade200,
      );

      expect(color, findsOneWidget);
      await tester.tap(color);

      Finder confirm = find.text('confirm');

      await tester.tap(confirm);
      await tester.pump(const Duration(seconds: 1));

      expect(result, completion(equals(Colors.blueGrey.shade200)));
    });

    testWidgets('color picker cancels selecting a color', (tester) async {
      tester.view.physicalSize = const Size(600, 1200);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      Future<Color?> result = Future.value(Colors.black);

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => NotedIconButton(
              icon: NotedIcons.eyedropper,
              type: NotedIconButtonType.simple,
              onPressed: () {
                result = showColorPicker(context, Colors.black, null);
              },
            ),
          ),
        ),
      );

      Finder button = find.byIcon(NotedIcons.eyedropper);
      await tester.tap(button);
      await tester.pump(const Duration(seconds: 1));

      Finder color = find.byWidgetPredicate(
        (widget) => widget is NotedColorPickerButton && widget.color == Colors.blueGrey.shade200,
      );

      expect(color, findsOneWidget);
      await tester.tap(color);

      Finder cancel = find.text('cancel');

      await tester.tap(cancel);
      await tester.pump(const Duration(seconds: 1));

      expect(result, completion(equals(null)));
    });
  });
}
