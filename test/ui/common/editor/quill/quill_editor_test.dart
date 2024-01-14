import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/editor/noted_editor_attributes.dart';
import 'package:noted_app/ui/common/editor/quill/quill_editor.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_models/noted_models.dart';

import '../../../../helpers/mocks/mock_callbacks.dart';
import '../../../../helpers/test_wrapper.dart';

void main() {
  group('Quill Editor', () {
    testWidgets('quill editor renders the proper editor', (tester) async {
      await tester.pumpWidget(
        TestWrapper(child: NotedEditor.quill(controller: NotedEditorController.quill())),
      );

      expect(find.byType(QuillEditor), findsOneWidget);
    });

    testWidgets('quill editor only supports a quill controller', (tester) async {
      await tester.pumpWidget(
        TestWrapper(child: NotedEditor.quill(controller: _MockController())),
      );

      expect(tester.takeException(), isInstanceOf<ArgumentError>());
    });

    testWidgets('quill editor handles tap', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: NotedEditor.quill(
            controller: NotedEditorController.quill(),
            onPressed: onPressed.call,
          ),
        ),
      );

      Finder editor = find.byType(QuillEditor);

      await tester.tap(editor);

      expect(editor, findsOneWidget);
      verify(() => onPressed()).called(1);
    });

    testWidgets('quill editor handles long tap', (tester) async {
      MockVoidCallback onLongPressed = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: NotedEditor.quill(
            controller: NotedEditorController.quill(),
            onLongPressed: onLongPressed.call,
          ),
        ),
      );

      Finder editor = find.byType(QuillEditor);

      await tester.longPress(editor);

      expect(editor, findsOneWidget);
      verify(() => onLongPressed()).called(1);
    });

    testWidgets('quill editor handles tap with invalid controller', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: NotedEditor.quill(
            controller: _MockController(),
            onPressed: onPressed.call,
          ),
        ),
      );

      expect(tester.takeException(), isInstanceOf<ArgumentError>());
    });
  });
}

class _MockController extends NotedEditorController {
  @override
  List get value => throw UnimplementedError();

  @override
  Stream<DocumentModel> get valueStream => throw UnimplementedError();

  @override
  set value(DocumentModel document) => throw UnimplementedError();

  @override
  Color? getColor(NotedEditorAttribute attribute) => throw UnimplementedError();

  @override
  String? getLink() => throw UnimplementedError();

  @override
  void insertEmbed(NotedEditorEmbed embed) => throw UnimplementedError();

  @override
  bool isAttributeToggled(NotedEditorAttribute attribute) => throw UnimplementedError();

  @override
  void setAttribute(NotedEditorAttribute attribute, bool value) => throw UnimplementedError();

  @override
  void setColor(NotedEditorAttribute attribute, Color? value) => throw UnimplementedError();

  @override
  void setLink(String? value) => throw UnimplementedError();
}
