import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_controller.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-start
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
// coverage:ignore-start

class QuillRichTextController extends NotedRichTextController {
  QuillController controller = QuillController.basic();

  QuillRichTextController({DocumentModel? initial}) {
    if (initial != null) {
      controller = QuillController(
        document: Document.fromDelta(Delta.fromJson(initial)),
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    controller.addListener(notifyListeners);
  }

  @override
  List<dynamic> get value => controller.document.toDelta().toJson();

  @override
  set value(DocumentModel document) => controller.document = Document.fromJson(document);

  @override
  bool isAttributeToggled(NotedRichTextAttribute attribute) {
    Attribute quillAttribute = _getQuillAttribute(attribute);

    switch (attribute) {
      case NotedRichTextAttribute.h1:
      case NotedRichTextAttribute.h2:
      case NotedRichTextAttribute.h3:
        return _isMultiAttributeToggled(quillAttribute, Attribute.header.key);
      case NotedRichTextAttribute.ol:
      case NotedRichTextAttribute.ul:
        return _isMultiAttributeToggled(quillAttribute, Attribute.list.key);
      case NotedRichTextAttribute.taskList:
        return _isTaskListToggled();
      default:
        Style style = controller.getSelectionStyle();
        return style.containsKey(quillAttribute.key);
    }
  }

  bool _isMultiAttributeToggled(Attribute toCheck, String key) {
    Style style = controller.getSelectionStyle();
    Attribute? attribute = style.attributes[key];

    if (attribute == null) {
      return false;
    }

    return attribute.value == toCheck.value;
  }

  bool _isTaskListToggled() {
    Style style = controller.getSelectionStyle();
    Attribute? attribute = style.attributes[Attribute.list.key];

    if (attribute == null) {
      return false;
    }

    return attribute.value == Attribute.unchecked.value || attribute.value == Attribute.checked.value;
  }

  @override
  void setAttribute(NotedRichTextAttribute attribute, bool value) {
    Attribute quillAttribute = _getQuillAttribute(attribute);
    controller.formatSelection(!value ? Attribute.clone(quillAttribute, null) : quillAttribute);
  }

  @override
  Color? getColor(NotedRichTextAttribute attribute) {
    Style style = controller.getSelectionStyle();
    Attribute quillAttribute = _getQuillAttribute(attribute);
    dynamic currentValue = style.attributes[quillAttribute.key]?.value;

    if (currentValue == null || currentValue is! String) {
      return null;
    }

    return NotedColorExtensions.fromHex(currentValue);
  }

  @override
  void setColor(NotedRichTextAttribute attribute, Color? value) {
    Attribute quillAttribute = _getQuillAttribute(attribute);
    controller.formatSelection(Attribute.clone(quillAttribute, value?.toHex()));
  }

  @override
  String? getLink() {
    Style style = controller.getSelectionStyle();
    Attribute quillAttribute = _getQuillAttribute(NotedRichTextAttribute.link);
    dynamic currentValue = style.attributes[quillAttribute.key]?.value;

    if (currentValue == null || currentValue is! String) {
      return null;
    }

    return currentValue;
  }

  @override
  void setLink(String? value) {
    Attribute quillAttribute = _getQuillAttribute(NotedRichTextAttribute.link);
    controller.formatSelection(Attribute.clone(quillAttribute, value?.isNotEmpty ?? false ? value : null));
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
