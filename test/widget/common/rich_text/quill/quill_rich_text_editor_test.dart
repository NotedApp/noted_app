import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/widget/common/noted_library.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/widget/common/rich_text/quill/quill_rich_text_editor.dart';

import '../../../test_wrapper.dart';

void main() {
  group('Quill Rich Text Editor', () {
    testWidgets('quill rich text editor renders the proper editor', (tester) async {
      await tester.pumpWidget(
        TestWrapper(child: NotedRichTextEditor.quill(controller: NotedRichTextController.quill())),
      );

      expect(find.byType(QuillRichTextEditor), findsOneWidget);
    });

    testWidgets('quill rich text editor only supports a quill controller', (tester) async {
      await tester.pumpWidget(
        TestWrapper(child: NotedRichTextEditor.quill(controller: _MockController())),
      );

      expect(tester.takeException(), isInstanceOf<ArgumentError>());
    });
  });
}

class _MockController extends NotedRichTextController {
  @override
  Color? getColor(NotedRichTextAttribute attribute) {
    throw UnimplementedError();
  }

  @override
  String? getLink() {
    throw UnimplementedError();
  }

  @override
  void insertEmbed(NotedRichTextEmbed embed) {
    throw UnimplementedError();
  }

  @override
  bool isAttributeToggled(NotedRichTextAttribute attribute) {
    throw UnimplementedError();
  }

  @override
  void setAttribute(NotedRichTextAttribute attribute, bool value) {
    throw UnimplementedError();
  }

  @override
  void setColor(NotedRichTextAttribute attribute, Color? value) {
    throw UnimplementedError();
  }

  @override
  void setLink(String? value) {
    throw UnimplementedError();
  }
}
