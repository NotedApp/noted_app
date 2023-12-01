import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/editor/noted_editor_attributes.dart';
import 'package:noted_app/ui/common/editor/quill/quill_editor_controller.dart';
import 'package:noted_models/noted_models.dart';

abstract class NotedEditorController extends ChangeNotifier {
  NotedEditorController();

  factory NotedEditorController.quill({DocumentModel? initial}) {
    return QuillEditorController(initial: initial);
  }

  DocumentModel get value;

  Stream<DocumentModel> get valueStream;

  set value(DocumentModel document);

  bool isAttributeToggled(NotedEditorAttribute attribute);

  void setAttribute(NotedEditorAttribute attribute, bool value);

  Color? getColor(NotedEditorAttribute attribute);

  void setColor(NotedEditorAttribute attribute, Color? value);

  String? getLink();

  void setLink(String? value);

  void insertEmbed(NotedEditorEmbed embed);
}
