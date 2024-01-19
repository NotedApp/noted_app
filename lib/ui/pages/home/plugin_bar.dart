import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';

const _tabs = ['all', 'notebook', 'cookbook'];
const _animationDuration = Duration(milliseconds: 250);

class PluginBar extends StatefulWidget {
  final PageController controller;

  const PluginBar({required this.controller, super.key});

  @override
  State<StatefulWidget> createState() => _PluginBarState();
}

class _PluginBarState extends State<PluginBar> with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      animationDuration: _animationDuration,
      length: _tabs.length,
      vsync: this,
    );

    widget.controller.addListener(updateTabPosition);
    tabController.addListener(updatePagePosition);
  }

  @override
  Widget build(BuildContext context) {
    return NotedTabBar(
      tabs: _tabs,
      controller: tabController,
      padding: const EdgeInsets.fromLTRB(15, 2, 15, 12),
    );
  }

  void updateTabPosition() {
    tabController.animateTo(widget.controller.page?.round() ?? 0);
  }

  void updatePagePosition() {
    widget.controller.animateToPage(
      tabController.index,
      duration: _animationDuration,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(updateTabPosition);
    tabController.removeListener(updatePagePosition);
    tabController.dispose();

    super.dispose();
  }
}
