import 'package:flutter_quill/flutter_quill.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_controller.dart';

Attribute _getQuillAttribute(NotedRichTextAttribute attribute) {
  return switch (attribute) {
    NotedRichTextAttribute.bold => Attribute.bold,
    NotedRichTextAttribute.italic => Attribute.italic,
    NotedRichTextAttribute.underline => Attribute.underline,
    NotedRichTextAttribute.strikethrough => Attribute.strikeThrough,
    NotedRichTextAttribute.h1 => Attribute.h1,
    NotedRichTextAttribute.h2 => Attribute.h2,
    NotedRichTextAttribute.h3 => Attribute.h3,
    NotedRichTextAttribute.textColor => Attribute.color,
    NotedRichTextAttribute.textBackground => Attribute.background,
    NotedRichTextAttribute.ul => Attribute.ul,
    NotedRichTextAttribute.ol => Attribute.ol,
    NotedRichTextAttribute.taskList => Attribute.unchecked,
    NotedRichTextAttribute.link => Attribute.link,
  };
}

class QuillRichTextController extends NotedRichTextController {
  QuillController controller = QuillController.basic();

  QuillRichTextController() {
    controller.addListener(notifyListeners);
  }

  @override
  bool isAttributeToggled(NotedRichTextAttribute attribute) {
    Attribute quillAttribute = _getQuillAttribute(attribute);

    switch (attribute) {
      case NotedRichTextAttribute.h1:
      case NotedRichTextAttribute.h2:
      case NotedRichTextAttribute.h3:
        return _isHeaderToggled(quillAttribute);
      default:
        Style style = controller.getSelectionStyle();
        return style.containsKey(quillAttribute.key);
    }
  }

  bool _isHeaderToggled(Attribute headerAttribute) {
    Style style = controller.getSelectionStyle();
    Attribute? attribute = style.attributes[headerAttribute.key];

    if (attribute == null || attribute.key != Attribute.header.key) {
      return false;
    }

    return attribute.value == headerAttribute.value;
  }

  @override
  void setAttribute(NotedRichTextAttribute attribute, bool value) {
    Attribute quillAttribute = _getQuillAttribute(attribute);
    controller.formatSelection(!value ? Attribute.clone(quillAttribute, null) : quillAttribute);
  }

  @override
  void insertEmbed(NotedRichTextEmbed embed) {
    // TODO: implement insertEmbed
  }

  @override
  void dispose() {
    controller.removeListener(notifyListeners);
    controller.dispose();
    super.dispose();
  }
}
