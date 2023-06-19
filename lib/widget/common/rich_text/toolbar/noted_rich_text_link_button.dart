import 'package:flutter/material.dart';
import 'package:noted_app/util/noted_strings.dart';
import 'package:noted_app/widget/common/button/noted_icon_button.dart';
import 'package:noted_app/widget/common/input/noted_string_picker.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_controller.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_utils.dart';

class NotedRichTextLinkButton extends StatelessWidget {
  final NotedRichTextController controller;
  final ColorScheme colors;

  const NotedRichTextLinkButton({
    required this.controller,
    required this.colors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NotedIconButton(
      icon: getAttributeIcon(NotedRichTextAttribute.link),
      type: NotedIconButtonType.simple,
      iconColor: colors.tertiary,
      backgroundColor: colors.secondary,
      onPressed: () => setLink(context),
    );
  }

  Future<void> setLink(BuildContext context) async {
    String? updated = await showStringPicker(
      context,
      controller.getLink() ?? '',
      title: NotedStrings.getString(NotedStringDomain.editor, 'linkPickerTitle'),
    );

    if (updated != null) {
      controller.setLink(updated);
    }
  }
}
