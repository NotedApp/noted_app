import 'package:flutter/material.dart';
import 'package:noted_app/theme/custom_colors.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_attributes.dart';
import 'package:noted_app/ui/common/rich_text/toolbar/home/noted_rich_text_colors_button.dart';
import 'package:noted_app/ui/common/rich_text/toolbar/home/noted_rich_text_toggle_button.dart';
import 'package:noted_app/util/extensions.dart';

part 'home/noted_rich_text_toolbar_home.dart';
part 'colors/noted_rich_text_toolbar_colors.dart';
part 'links/noted_rich_text_toolbar_links.dart';

typedef ToolbarStateCallback = void Function(_ToolbarState);

enum _ToolbarState {
  home,
  textColor,
  highlightColor,
  link,
}

Key _homeKey = Key(_ToolbarState.home.name);
Key _textColorKey = Key(_ToolbarState.textColor.name);
Key _highlightColorKey = Key(_ToolbarState.highlightColor.name);
Key _linkKey = Key(_ToolbarState.link.name);

class NotedRichTextToolbar extends StatefulWidget {
  final NotedRichTextController controller;

  const NotedRichTextToolbar({required this.controller, super.key});

  @override
  State<StatefulWidget> createState() => _NotedRichTextToolbarState();
}

class _NotedRichTextToolbarState extends State<NotedRichTextToolbar> {
  _ToolbarState state = _ToolbarState.home;

  void setToolbarState(_ToolbarState newState) {
    setState(() => state = newState);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      height: 116,
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
          _ToolbarState.home => _ToolbarHome(
              controller: widget.controller,
              setToolbarState: setToolbarState,
              key: _homeKey,
            ),
          _ToolbarState.textColor => _ToolbarColorPicker(
              controller: widget.controller,
              attribute: NotedRichTextAttribute.textColor,
              defaultColor: colors.onBackground,
              setToolbarState: setToolbarState,
              key: _textColorKey,
            ),
          _ToolbarState.highlightColor => _ToolbarColorPicker(
              controller: widget.controller,
              attribute: NotedRichTextAttribute.textBackground,
              defaultColor: colors.background,
              setToolbarState: setToolbarState,
              key: _highlightColorKey,
            ),
          _ToolbarState.link => _ToolbarLinkPicker(
              controller: widget.controller,
              setToolbarState: setToolbarState,
              key: _linkKey,
            ),
        },
      ),
    );
  }
}
