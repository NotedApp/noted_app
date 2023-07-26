import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_controller.dart';
import 'package:noted_app/ui/common/rich_text/toolbar/home/noted_rich_text_color_button.dart';
import 'package:noted_app/ui/common/rich_text/toolbar/home/noted_rich_text_link_button.dart';
import 'package:noted_app/ui/common/rich_text/toolbar/home/noted_rich_text_toggle_button.dart';

part 'home/noted_rich_text_toolbar_home.dart';
part 'colors/noted_rich_text_toolbar_colors.dart';

enum _ToolbarState {
  home,
  colors,
}

Key _homeKey = Key(_ToolbarState.home.name);
Key _colorsKey = Key(_ToolbarState.colors.name);

class NotedRichTextToolbar extends StatefulWidget {
  final NotedRichTextController controller;

  const NotedRichTextToolbar({required this.controller, super.key});

  @override
  State<StatefulWidget> createState() => _NotedRichTextToolbarState();
}

class _NotedRichTextToolbarState extends State<NotedRichTextToolbar> {
  _ToolbarState state = _ToolbarState.home;

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: colors.onBackground.withAlpha(64),
            blurRadius: 4,
          ),
        ],
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (Widget child, Animation<double> animation) => SlideTransition(
          position: Tween(
            begin: child.key == _homeKey ? Offset(-1.0, 0.0) : Offset(1.0, 0.0),
            end: Offset(0.0, 0.0),
          ).animate(animation),
          child: child,
        ),
        child: switch (state) {
          _ToolbarState.home => _ToolbarHome(controller: widget.controller, key: _homeKey),
          _ToolbarState.colors => _ToolbarColorPicker(controller: widget.controller, key: _colorsKey),
        },
      ),
    );
  }
}
