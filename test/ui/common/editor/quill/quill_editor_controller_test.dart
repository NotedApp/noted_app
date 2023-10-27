import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/ui/common/editor/noted_editor_attributes.dart';
import 'package:noted_app/ui/common/editor/quill/quill_editor_controller.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../../helpers/mocks/mock_delta.dart';

void main() {
  group('Quill Editor Controller', () {
    late QuillEditorController controller;

    setUp(() {
      controller = NotedEditorController.quill(
        initial: testData0,
      ) as QuillEditorController;
    });

    test('creates a controller with initial data, and updates data', () {
      controller.controller.updateSelection(TextSelection(baseOffset: 0, extentOffset: 11), ChangeSource.LOCAL);
      expect(controller.controller.getPlainText(), 'hello world');

      controller.value = testData1;
      expect(controller.value, testData1);
    });

    test('validates and updates bold formatting', () {
      controller.controller.updateSelection(TextSelection(baseOffset: 0, extentOffset: 11), ChangeSource.LOCAL);
      expect(controller.isAttributeToggled(NotedEditorAttribute.bold), false);

      controller.setAttribute(NotedEditorAttribute.bold, true);
      expect(controller.isAttributeToggled(NotedEditorAttribute.bold), true);

      controller.setAttribute(NotedEditorAttribute.bold, false);
      expect(controller.isAttributeToggled(NotedEditorAttribute.bold), false);
    });

    test('validates and updates header formatting', () {
      controller.controller.updateSelection(TextSelection(baseOffset: 0, extentOffset: 11), ChangeSource.LOCAL);
      expect(controller.isAttributeToggled(NotedEditorAttribute.h1), false);

      controller.setAttribute(NotedEditorAttribute.h1, true);
      expect(controller.isAttributeToggled(NotedEditorAttribute.h1), true);
      expect(controller.isAttributeToggled(NotedEditorAttribute.h2), false);

      controller.setAttribute(NotedEditorAttribute.h1, false);
      expect(controller.isAttributeToggled(NotedEditorAttribute.h1), false);
    });

    test('validates and updates color formatting', () {
      controller.controller.updateSelection(TextSelection(baseOffset: 0, extentOffset: 11), ChangeSource.LOCAL);
      expect(controller.getColor(NotedEditorAttribute.textColor), null);

      controller.setColor(NotedEditorAttribute.textColor, red500);
      expect(controller.getColor(NotedEditorAttribute.textColor), red500);

      controller.setColor(NotedEditorAttribute.textColor, null);
      expect(controller.getColor(NotedEditorAttribute.textColor), null);
    });

    test('validates and updates list formatting', () {
      controller.controller.updateSelection(TextSelection(baseOffset: 0, extentOffset: 11), ChangeSource.LOCAL);
      expect(controller.isAttributeToggled(NotedEditorAttribute.ul), false);

      controller.setAttribute(NotedEditorAttribute.ul, true);
      expect(controller.isAttributeToggled(NotedEditorAttribute.ul), true);
      expect(controller.isAttributeToggled(NotedEditorAttribute.ol), false);

      controller.setAttribute(NotedEditorAttribute.ul, false);
      expect(controller.isAttributeToggled(NotedEditorAttribute.ul), false);
    });

    test('validates and updates task list formatting', () {
      controller.controller.updateSelection(TextSelection(baseOffset: 0, extentOffset: 11), ChangeSource.LOCAL);
      expect(controller.isAttributeToggled(NotedEditorAttribute.taskList), false);

      controller.setAttribute(NotedEditorAttribute.taskList, true);
      expect(controller.isAttributeToggled(NotedEditorAttribute.taskList), true);
      expect(controller.isAttributeToggled(NotedEditorAttribute.ol), false);
      expect(controller.isAttributeToggled(NotedEditorAttribute.ul), false);

      controller.setAttribute(NotedEditorAttribute.taskList, false);
      expect(controller.isAttributeToggled(NotedEditorAttribute.taskList), false);
    });

    test('validates and updates link formatting', () {
      controller.controller.updateSelection(TextSelection(baseOffset: 0, extentOffset: 11), ChangeSource.LOCAL);
      expect(controller.getLink(), null);

      controller.setLink('test.com');
      expect(controller.getLink(), 'test.com');

      controller.setLink(null);
      expect(controller.getLink(), null);
    });

    test('validates inserting an embed', () {
      controller.insertEmbed(NotedEditorEmbed.image);
    });

    test('calls controller dispose on dispose', () {
      controller.dispose();
      expect(() => controller.controller.dispose(), throwsA(isA<FlutterError>()));
    });
  });
}
