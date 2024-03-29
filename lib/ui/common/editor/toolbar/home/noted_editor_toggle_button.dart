import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/button/noted_icon_button.dart';
import 'package:noted_app/ui/common/editor/noted_editor_attributes.dart';
import 'package:noted_app/ui/common/editor/noted_editor_controller.dart';

class NotedEditorToggleButton extends StatefulWidget {
  final NotedEditorController controller;
  final NotedEditorAttribute attribute;
  final ColorScheme colors;

  const NotedEditorToggleButton({
    required this.controller,
    required this.attribute,
    required this.colors,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _NotedEditorButtonState();
}

class _NotedEditorButtonState extends State<NotedEditorToggleButton> {
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
      icon: widget.attribute.icon,
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
