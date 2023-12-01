import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/editor/noted_editor_attributes.dart';
import 'package:noted_app/ui/common/editor/toolbar/home/noted_editor_state_button.dart';
import 'package:noted_app/ui/common/editor/toolbar/home/noted_editor_toggle_button.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';

part 'home/noted_editor_toolbar_home.dart';
part 'colors/noted_editor_toolbar_colors.dart';
part 'links/noted_editor_toolbar_links.dart';

typedef _ToolbarStateCallback = void Function(_ToolbarState);

enum _ToolbarState {
  home,
  textColor,
  highlightColor,
  link,
}

final Key _homeKey = Key(_ToolbarState.home.name);
final Key _textColorKey = Key(_ToolbarState.textColor.name);
final Key _highlightColorKey = Key(_ToolbarState.highlightColor.name);
final Key _linkKey = Key(_ToolbarState.link.name);

class NotedEditorToolbar extends StatefulWidget {
  final NotedEditorController controller;

  const NotedEditorToolbar({required this.controller, super.key});

  @override
  State<StatefulWidget> createState() => _NotedEditorToolbarState();
}

class _NotedEditorToolbarState extends State<NotedEditorToolbar> {
  _ToolbarState state = _ToolbarState.home;

  void setToolbarState(_ToolbarState newState) {
    setState(() => state = newState);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      height: 112,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
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
            begin: child.key == _homeKey ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0),
            end: Offset.zero,
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
              attribute: NotedEditorAttribute.textColor,
              defaultColor: colors.onBackground,
              setToolbarState: setToolbarState,
              key: _textColorKey,
            ),
          _ToolbarState.highlightColor => _ToolbarColorPicker(
              controller: widget.controller,
              attribute: NotedEditorAttribute.textBackground,
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
