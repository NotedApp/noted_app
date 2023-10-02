import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/ui/common/rich_text/quill/quill_rich_text_controller.dart';

import '../../../../helpers/environment/unit_test_environment.dart';
import '../../../../helpers/mocks/mock_delta.dart';
import '../../../../helpers/test_wrapper.dart';

void main() {
  setUpAll(() {
    UnitTestEnvironment().configure();
  });

  group('Quill Rich Text Toolbar', () {
    late QuillRichTextController controller;

    setUp(() {
      controller = NotedRichTextController.quill(
        initial: testData0,
      ) as QuillRichTextController;
    });

    testWidgets('renders a set of formatting buttons', (tester) async {
      await tester.pumpWidget(TestWrapper(child: NotedRichTextToolbar(controller: controller)));

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
      controller.controller.updateSelection(TextSelection(baseOffset: 0, extentOffset: 11), ChangeSource.LOCAL);
      await tester.pumpWidget(TestWrapper(child: NotedRichTextToolbar(controller: controller)));

      expect(controller.isAttributeToggled(NotedRichTextAttribute.bold), false);

      await tester.tap(find.byIcon(NotedIcons.bold));
      await tester.pumpAndSettle();

      expect(controller.isAttributeToggled(NotedRichTextAttribute.bold), true);

      await tester.tap(find.byIcon(NotedIcons.bold));
      await tester.pumpAndSettle();

      expect(controller.isAttributeToggled(NotedRichTextAttribute.bold), false);
    });

    testWidgets('toggles a link', (tester) async {
      controller.controller.updateSelection(TextSelection(baseOffset: 0, extentOffset: 11), ChangeSource.LOCAL);
      await tester.pumpWidget(TestWrapper(child: NotedRichTextToolbar(controller: controller)));

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
      await tester.pumpWidget(TestWrapper(child: NotedRichTextToolbar(controller: controller)));

      await tester.tap(find.byIcon(NotedIcons.textColor));
      await tester.pumpAndSettle(const Duration(milliseconds: 200));

      Finder color = find.byWidgetPredicate(
        (widget) => widget is NotedColorPickerButton && widget.color == blueGrey500,
      );

      await tester.tap(color);
      await tester.pumpAndSettle();

      expect(controller.getColor(NotedRichTextAttribute.textColor), blueGrey500);
    });
  });
}
