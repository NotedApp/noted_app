import 'package:flutter_quill/flutter_quill.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_controller.dart';

class QuillRichTextController extends NotedRichTextController {
  QuillController controller = QuillController.basic();

  QuillRichTextController() {
    controller.addListener(() {
      notifyListeners();
    });
  }

  @override
  bool isAttributeToggled(NotedRichTextAttribute attribute) {
    // TODO: implement isAttributeToggled
    throw UnimplementedError();
  }

  @override
  void toggleAttribute(NotedRichTextAttribute attribute) {
    // TODO: implement toggleAttribute
  }

  @override
  void insertEmbed(NotedRichTextEmbed embed) {
    // TODO: implement insertEmbed
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
