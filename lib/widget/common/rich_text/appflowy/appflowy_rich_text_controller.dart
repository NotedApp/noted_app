import 'dart:async';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_controller.dart';

class AppflowyRichTextController extends NotedRichTextController {
  final EditorState editorState = EditorState.blank();
  StreamSubscription? _editorSubscription;

  AppflowyRichTextController() {
    _editorSubscription = editorState.transactionStream.listen((_) => notifyListeners());
  }

  @override
  bool isAttributeToggled(NotedRichTextAttribute attribute) {
    // TODO: implement isAttributeToggled
    throw UnimplementedError();
  }

  @override
  void setAttribute(NotedRichTextAttribute attribute, bool value) {
    // TODO: implement toggleAttribute
  }

  @override
  void insertEmbed(NotedRichTextEmbed embed) {
    // TODO: implement insertEmbed
  }

  @override
  void dispose() {
    _editorSubscription?.cancel();
    editorState.cancelSubscription();
    super.dispose();
  }
}
