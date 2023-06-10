import 'package:noted_app/widget/common/rich_text/quill/quill_rich_text_controller.dart';

abstract class NotedRichTextController {
  const NotedRichTextController();

  factory NotedRichTextController.quill() {
    return QuillRichTextController();
  }

  void dispose();
}
