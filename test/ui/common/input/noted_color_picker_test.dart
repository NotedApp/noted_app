import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:noted_app/theme/custom_colors.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/common.dart';
import '../../test_wrapper.dart';

void main() {
  group('Noted Color Picker', () {
    testWidgets('color picker renders all colors and resets default', (tester) async {
      tester.view.physicalSize = Size(600, 1200);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      MockVoidCallback onReset = MockVoidCallback();
      Future<Color?> result = Future.value(black);

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => NotedIconButton(
              icon: NotedIcons.eyedropper,
              type: NotedIconButtonType.simple,
              onPressed: () {
                result = showColorPicker(context, black, onReset);
              },
            ),
          ),
        ),
      );

      Finder button = find.byIcon(NotedIcons.eyedropper);
      await tester.tap(button);
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(NotedColorPickerButton), findsNWidgets(36));

      Finder reset = find.byWidgetPredicate(
        (widget) => widget is NotedTextButton && widget.type == NotedTextButtonType.outlined,
      );

      expect(reset, findsOneWidget);

      await tester.tap(reset);
      await tester.pump(const Duration(seconds: 1));

      expect(result, completion(equals(null)));
      verify(onReset()).called(1);
    });

    testWidgets('color picker selects a color', (tester) async {
      tester.view.physicalSize = Size(600, 1200);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      Future<Color?> result = Future.value(black);

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => NotedIconButton(
              icon: NotedIcons.eyedropper,
              type: NotedIconButtonType.simple,
              onPressed: () {
                result = showColorPicker(context, black, null);
              },
            ),
          ),
        ),
      );

      Finder button = find.byIcon(NotedIcons.eyedropper);
      await tester.tap(button);
      await tester.pump(const Duration(seconds: 1));

      Finder color = find.byWidgetPredicate(
        (widget) => widget is NotedColorPickerButton && widget.color == blueGrey200,
      );

      expect(color, findsOneWidget);
      await tester.tap(color);

      Finder confirm = find.byWidgetPredicate(
        (widget) => widget is NotedTextButton && widget.type == NotedTextButtonType.simple,
      );

      await tester.tap(confirm.first);
      await tester.pump(const Duration(seconds: 1));

      expect(result, completion(equals(blueGrey200)));
    });

    testWidgets('color picker cancels selecting a color', (tester) async {
      tester.view.physicalSize = Size(600, 1200);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      Future<Color?> result = Future.value(black);

      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => NotedIconButton(
              icon: NotedIcons.eyedropper,
              type: NotedIconButtonType.simple,
              onPressed: () {
                result = showColorPicker(context, black, null);
              },
            ),
          ),
        ),
      );

      Finder button = find.byIcon(NotedIcons.eyedropper);
      await tester.tap(button);
      await tester.pump(const Duration(seconds: 1));

      Finder color = find.byWidgetPredicate(
        (widget) => widget is NotedColorPickerButton && widget.color == blueGrey200,
      );

      expect(color, findsOneWidget);
      await tester.tap(color);

      Finder cancel = find.byWidgetPredicate(
        (widget) => widget is NotedTextButton && widget.type == NotedTextButtonType.simple,
      );

      await tester.tap(cancel.last);
      await tester.pump(const Duration(seconds: 1));

      expect(result, completion(equals(null)));
    });
  });
}
