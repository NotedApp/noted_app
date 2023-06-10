import 'package:noted_app/widget/common/rich_text/fleather/fleather_rich_text_controller.dart';
import 'package:noted_app/widget/common/rich_text/quill/quill_rich_text_controller.dart';

abstract class NotedRichTextController {
  const NotedRichTextController();

  factory NotedRichTextController.quill() {
    return QuillRichTextController();
  }

  factory NotedRichTextController.fleather() {
    return FleatherRichTextController();
  }

  void dispose();
}
