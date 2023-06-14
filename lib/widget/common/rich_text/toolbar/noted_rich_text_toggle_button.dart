import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/button/noted_icon_button.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_controller.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_utils.dart';

class NotedRichTextToggleButton extends StatefulWidget {
  final NotedRichTextController controller;
  final NotedRichTextAttribute attribute;
  final ColorScheme colors;

  const NotedRichTextToggleButton({
    required this.controller,
    required this.attribute,
    required this.colors,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _NotedRichTextButtonState();
}

class _NotedRichTextButtonState extends State<NotedRichTextToggleButton> {
  bool isToggled = false;

  @override
  void initState() {
    super.initState();
    isToggled = widget.controller.isAttributeToggled(widget.attribute);
    widget.controller.addListener(updateToggled);
  }

  @override
  Widget build(BuildContext context) {
    return NotedIconButton(
      icon: getAttributeIcon(widget.attribute),
      type: NotedIconButtonType.simple,
      iconColor: isToggled ? widget.colors.secondary : widget.colors.tertiary,
      backgroundColor: isToggled ? widget.colors.tertiary : widget.colors.secondary,
      onPressed: setToggled,
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(updateToggled);
    super.dispose();
  }

  void updateToggled() {
    setState(() {
      isToggled = widget.controller.isAttributeToggled(widget.attribute);
    });
  }

  void setToggled() {
    widget.controller.setAttribute(widget.attribute, !isToggled);
  }
}
