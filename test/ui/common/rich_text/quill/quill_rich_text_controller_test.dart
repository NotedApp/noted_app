import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/ui/common/rich_text/quill/quill_rich_text_controller.dart';

import '../../../../helpers/mocks/mock_delta.dart';

void main() {
  group('Quill Rich Text Controller', () {
    test('creates a controller with initial data', () {
      QuillRichTextController controller = NotedRichTextController.quill(
        initial: testData0,
      ) as QuillRichTextController;

      controller.controller.updateSelection(TextSelection(baseOffset: 0, extentOffset: 11), ChangeSource.LOCAL);
      expect(controller.controller.getPlainText(), 'hello world');
    });

    test('validates and updates bold formatting', () {
      QuillRichTextController controller = NotedRichTextController.quill(
        initial: testData0,
      ) as QuillRichTextController;

      controller.controller.updateSelection(TextSelection(baseOffset: 0, extentOffset: 11), ChangeSource.LOCAL);
      expect(controller.isAttributeToggled(NotedRichTextAttribute.bold), false);

      controller.setAttribute(NotedRichTextAttribute.bold, true);
      expect(controller.isAttributeToggled(NotedRichTextAttribute.bold), true);

      controller.setAttribute(NotedRichTextAttribute.bold, false);
      expect(controller.isAttributeToggled(NotedRichTextAttribute.bold), false);
    });

    test('validates and updates header formatting', () {
      QuillRichTextController controller = NotedRichTextController.quill(
        initial: testData0,
      ) as QuillRichTextController;

      controller.controller.updateSelection(TextSelection(baseOffset: 0, extentOffset: 11), ChangeSource.LOCAL);
      expect(controller.isAttributeToggled(NotedRichTextAttribute.h1), false);

      controller.setAttribute(NotedRichTextAttribute.h1, true);
      expect(controller.isAttributeToggled(NotedRichTextAttribute.h1), true);
      expect(controller.isAttributeToggled(NotedRichTextAttribute.h2), false);

      controller.setAttribute(NotedRichTextAttribute.h1, false);
      expect(controller.isAttributeToggled(NotedRichTextAttribute.h1), false);
    });
  });
}
