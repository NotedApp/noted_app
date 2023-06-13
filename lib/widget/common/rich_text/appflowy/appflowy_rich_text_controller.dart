import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_controller.dart';

class AppflowyRichTextController extends NotedRichTextController {
  EditorState editorState = EditorState.blank();

  @override
  void dispose() {}
}
