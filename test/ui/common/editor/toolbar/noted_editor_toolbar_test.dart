import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/ui/common/editor/noted_editor_attributes.dart';
import 'package:noted_app/ui/common/editor/quill/quill_editor_controller.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../../helpers/environment/unit_test_environment.dart';
import '../../../../helpers/mocks/mock_delta.dart';
import '../../../../helpers/test_wrapper.dart';

void main() {
  setUpAll(() {
    UnitTestEnvironment().configure();
  });

  group('Quill Editor Toolbar', () {
    late QuillEditorController controller;

    setUp(() {
      controller = NotedEditorController.quill(
        initial: testData0,
      ) as QuillEditorController;
    });

    testWidgets('expands and collapses', (tester) async {
      await tester.pumpWidget(TestWrapper(child: NotedEditorToolbar(controller: controller)));

      Finder toolbar = find.byType(NotedEditorToolbar);

      await tester.drag(toolbar, const Offset(0, 100));
      await tester.pumpAndSettle();

      await tester.drag(toolbar, const Offset(0, -100));
      await tester.pumpAndSettle();
    });

    testWidgets('renders a set of formatting buttons', (tester) async {
      await tester.pumpWidget(TestWrapper(child: NotedEditorToolbar(controller: controller)));

      expect(find.byType(NotedIconButton), findsNWidgets(13));

      await tester.tap(find.byIcon(NotedIcons.textColor));
      await tester.pumpAndSettle();

      expect(find.byType(NotedColorPickerButton), findsNWidgets(12));

      await tester.tap(find.byIcon(NotedIcons.chevronLeft));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(NotedIcons.backgroundColor));
      await tester.pumpAndSettle();

      expect(find.byType(NotedColorPickerButton), findsNWidgets(12));
    });

    testWidgets('toggles formatting', (tester) async {
      controller.controller.updateSelection(const TextSelection(baseOffset: 0, extentOffset: 11), ChangeSource.local);
      await tester.pumpWidget(TestWrapper(child: NotedEditorToolbar(controller: controller)));

      expect(controller.isAttributeToggled(NotedEditorAttribute.bold), false);

      await tester.tap(find.byIcon(NotedIcons.bold));
      await tester.pumpAndSettle();

      expect(controller.isAttributeToggled(NotedEditorAttribute.bold), true);

      await tester.tap(find.byIcon(NotedIcons.bold));
      await tester.pumpAndSettle();

      expect(controller.isAttributeToggled(NotedEditorAttribute.bold), false);
    });

    testWidgets('toggles a link', (tester) async {
      controller.controller.updateSelection(const TextSelection(baseOffset: 0, extentOffset: 11), ChangeSource.local);
      await tester.pumpWidget(TestWrapper(child: NotedEditorToolbar(controller: controller)));

      expect(controller.getLink(), null);

      await tester.tap(find.byIcon(NotedIcons.link));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(NotedTextField), 'test.com');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(controller.getLink(), 'test.com');

      await tester.tap(find.byIcon(NotedIcons.chevronLeft));
      await tester.pumpAndSettle();

      expect(find.byType(NotedIconButton), findsNWidgets(13));
    });

    testWidgets('updates the text color', (tester) async {
      await tester.pumpWidget(TestWrapper(child: NotedEditorToolbar(controller: controller)));

      await tester.tap(find.byIcon(NotedIcons.textColor));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      Finder color = find.byWidgetPredicate(
        (widget) => widget is NotedColorPickerButton && widget.color == Colors.blueGrey.shade500,
      );

      await tester.tap(color);
      await tester.pumpAndSettle();

      expect(controller.getColor(NotedEditorAttribute.textColor), Colors.blueGrey.shade500);
    });
  });
}
