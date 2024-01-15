import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:noted_app/ui/common/editor/noted_editor_attributes.dart';
import 'package:noted_app/ui/common/editor/noted_editor_controller.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-start
Attribute _getQuillAttribute(NotedEditorAttribute attribute) {
  return switch (attribute) {
    NotedEditorAttribute.bold => Attribute.bold,
    NotedEditorAttribute.italic => Attribute.italic,
    NotedEditorAttribute.underline => Attribute.underline,
    NotedEditorAttribute.strikethrough => Attribute.strikeThrough,
    NotedEditorAttribute.h1 => Attribute.h1,
    NotedEditorAttribute.h2 => Attribute.h2,
    NotedEditorAttribute.h3 => Attribute.h3,
    NotedEditorAttribute.textColor => Attribute.color,
    NotedEditorAttribute.textBackground => Attribute.background,
    NotedEditorAttribute.ul => Attribute.ul,
    NotedEditorAttribute.ol => Attribute.ol,
    NotedEditorAttribute.taskList => Attribute.unchecked,
    NotedEditorAttribute.link => Attribute.link,
  };
}
// coverage:ignore-start

class QuillEditorController extends NotedEditorController {
  QuillController controller = QuillController.basic();

  QuillEditorController({DocumentModel? initial}) {
    if (initial != null) {
      controller = QuillController(
        document: Document.fromDelta(Delta.fromJson(initial)),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    controller.addListener(notifyListeners);
  }

  @override
  List<dynamic> get value => controller.document.toDelta().toJson();

  @override
  Stream<DocumentModel> get valueStream => controller.changes.map((event) => value);

  @override
  set value(DocumentModel document) => controller.document = Document.fromJson(document);

  @override
  bool isAttributeToggled(NotedEditorAttribute attribute) {
    Attribute quillAttribute = _getQuillAttribute(attribute);

    switch (attribute) {
      case NotedEditorAttribute.h1:
      case NotedEditorAttribute.h2:
      case NotedEditorAttribute.h3:
        return _isMultiAttributeToggled(quillAttribute, Attribute.header.key);
      case NotedEditorAttribute.ol:
      case NotedEditorAttribute.ul:
        return _isMultiAttributeToggled(quillAttribute, Attribute.list.key);
      case NotedEditorAttribute.taskList:
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
  void setAttribute(NotedEditorAttribute attribute, bool value) {
    Attribute quillAttribute = _getQuillAttribute(attribute);
    controller.formatSelection(!value ? Attribute.clone(quillAttribute, null) : quillAttribute);
  }

  @override
  Color? getColor(NotedEditorAttribute attribute) {
    Style style = controller.getSelectionStyle();
    Attribute quillAttribute = _getQuillAttribute(attribute);
    dynamic currentValue = style.attributes[quillAttribute.key]?.value;

    if (currentValue == null || currentValue is! String) {
      return null;
    }

    return NotedColorExtensions.fromHex(currentValue);
  }

  @override
  void setColor(NotedEditorAttribute attribute, Color? value) {
    Attribute quillAttribute = _getQuillAttribute(attribute);
    controller.formatSelection(Attribute.clone(quillAttribute, value?.toHex()));
  }

  @override
  String? getLink() {
    Style style = controller.getSelectionStyle();
    Attribute quillAttribute = _getQuillAttribute(NotedEditorAttribute.link);
    dynamic currentValue = style.attributes[quillAttribute.key]?.value;

    if (currentValue == null || currentValue is! String) {
      return null;
    }

    return currentValue;
  }

  @override
  void setLink(String? value) {
    Attribute quillAttribute = _getQuillAttribute(NotedEditorAttribute.link);
    controller.formatSelection(Attribute.clone(quillAttribute, value?.isNotEmpty ?? false ? value : null));
  }

  @override
  void insertEmbed(NotedEditorEmbed embed) {
    // TODO: implement insertEmbed
  }

  @override
  void dispose() {
    controller.removeListener(notifyListeners);
    controller.dispose();
    super.dispose();
  }
}
