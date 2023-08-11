// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/icon/noted_icons.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_attributes.dart';

IconData getAttributeIcon(NotedRichTextAttribute attribute) {
  return switch (attribute) {
    NotedRichTextAttribute.bold => NotedIcons.bold,
    NotedRichTextAttribute.italic => NotedIcons.italic,
    NotedRichTextAttribute.underline => NotedIcons.underline,
    NotedRichTextAttribute.strikethrough => NotedIcons.strikethrough,
    NotedRichTextAttribute.h1 => NotedIcons.h1,
    NotedRichTextAttribute.h2 => NotedIcons.h2,
    NotedRichTextAttribute.h3 => NotedIcons.h3,
    NotedRichTextAttribute.textColor => NotedIcons.textColor,
    NotedRichTextAttribute.textBackground => NotedIcons.backgroundColor,
    NotedRichTextAttribute.ul => NotedIcons.unorderedList,
    NotedRichTextAttribute.ol => NotedIcons.orderedList,
    NotedRichTextAttribute.taskList => NotedIcons.taskList,
    NotedRichTextAttribute.link => NotedIcons.link,
  };
}
