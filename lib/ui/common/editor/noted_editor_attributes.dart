import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';

enum NotedEditorAttribute {
  bold,
  italic,
  underline,
  strikethrough,
  h1,
  h2,
  h3,
  textColor,
  textBackground,
  ul,
  ol,
  taskList,
  link,
}

extension AttributeIcons on NotedEditorAttribute {
  IconData get icon => switch (this) {
        NotedEditorAttribute.bold => NotedIcons.bold,
        NotedEditorAttribute.italic => NotedIcons.italic,
        NotedEditorAttribute.underline => NotedIcons.underline,
        NotedEditorAttribute.strikethrough => NotedIcons.strikethrough,
        NotedEditorAttribute.h1 => NotedIcons.h1,
        NotedEditorAttribute.h2 => NotedIcons.h2,
        NotedEditorAttribute.h3 => NotedIcons.h3,
        NotedEditorAttribute.textColor => NotedIcons.textColor,
        NotedEditorAttribute.textBackground => NotedIcons.backgroundColor,
        NotedEditorAttribute.ul => NotedIcons.unorderedList,
        NotedEditorAttribute.ol => NotedIcons.orderedList,
        NotedEditorAttribute.taskList => NotedIcons.taskList,
        NotedEditorAttribute.link => NotedIcons.link,
      };
}

enum NotedEditorEmbed {
  image,
  video,
  audio,
}
