import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/editor/noted_editor_attributes.dart';
import 'package:noted_app/ui/common/editor/toolbar/home/noted_editor_state_button.dart';
import 'package:noted_app/ui/common/editor/toolbar/home/noted_editor_toggle_button.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';

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

const double _toolbarHandleHeight = 4;
const double _toolbarHandleWidth = 24;
const double _toolbarHandlePadding = 6;

const Duration _toolbarAnimationDuration = Duration(milliseconds: 200);
const double _toolbarMaxHeight = 112;
const double _toolbarMinHeight = 32;
const double _toolbarMidHeight = (_toolbarMaxHeight + _toolbarMinHeight) / 2;
const EdgeInsets _toolbarPadding = EdgeInsets.fromLTRB(14, 16, 14, 4);

class NotedEditorToolbar extends StatefulWidget {
  final NotedEditorController controller;

  const NotedEditorToolbar({required this.controller, super.key});

  @override
  State<StatefulWidget> createState() => _NotedEditorToolbarState();
}

class _NotedEditorToolbarState extends State<NotedEditorToolbar> {
  _ToolbarState state = _ToolbarState.home;
  double toolbarHeight = _toolbarMaxHeight;

  void setToolbarState(_ToolbarState newState) {
    setState(() => state = newState);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        final double dragY = details.delta.dy;
        final double heightY = clampDouble(toolbarHeight - dragY, _toolbarMinHeight, _toolbarMaxHeight);
        setState(() => toolbarHeight = heightY);
      },
      onVerticalDragEnd: (details) {
        final double snappedHeight = toolbarHeight > _toolbarMidHeight ? _toolbarMaxHeight : _toolbarMinHeight;
        setState(() => toolbarHeight = snappedHeight);
      },
      child: AnimatedContainer(
        duration: _toolbarAnimationDuration,
        curve: Curves.easeInOut,
        width: double.infinity,
        height: toolbarHeight,
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
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned.fill(
              child: _NotedEditorToolbarContent(
                opacity: (toolbarHeight - _toolbarMinHeight) / (_toolbarMaxHeight - _toolbarMinHeight),
                state: state,
                setState: setToolbarState,
                controller: widget.controller,
              ),
            ),
            const _NotedEditorToolbarDragHandle(),
          ],
        ),
      ),
    );
  }
}

class _NotedEditorToolbarDragHandle extends StatelessWidget {
  const _NotedEditorToolbarDragHandle();

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: _toolbarHandlePadding),
      child: Container(
        width: _toolbarHandleWidth,
        height: _toolbarHandleHeight,
        decoration: BoxDecoration(
          color: colors.tertiary,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(_toolbarHandleHeight / 2),
            bottom: Radius.circular(_toolbarHandleHeight / 2),
          ),
        ),
      ),
    );
  }
}

class _NotedEditorToolbarContent extends StatelessWidget {
  final double opacity;
  final _ToolbarState state;
  final void Function(_ToolbarState) setState;
  final NotedEditorController controller;

  const _NotedEditorToolbarContent({
    required this.opacity,
    required this.state,
    required this.setState,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return AnimatedOpacity(
      opacity: opacity,
      duration: _toolbarAnimationDuration,
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
              controller: controller,
              setToolbarState: setState,
              key: _homeKey,
            ),
          _ToolbarState.textColor => _ToolbarColorPicker(
              controller: controller,
              attribute: NotedEditorAttribute.textColor,
              defaultColor: colors.onBackground,
              setToolbarState: setState,
              key: _textColorKey,
            ),
          _ToolbarState.highlightColor => _ToolbarColorPicker(
              controller: controller,
              attribute: NotedEditorAttribute.textBackground,
              defaultColor: colors.background,
              setToolbarState: setState,
              key: _highlightColorKey,
            ),
          _ToolbarState.link => _ToolbarLinkPicker(
              controller: controller,
              setToolbarState: setState,
              key: _linkKey,
            ),
        },
      ),
    );
  }
}
