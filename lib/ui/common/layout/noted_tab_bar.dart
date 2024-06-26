import 'package:flutter/material.dart';

class NotedTabBar extends StatelessWidget {
  final List<String> tabs;
  final TabController? controller;
  final ValueChanged<int>? onPressed;
  final EdgeInsets padding;

  const NotedTabBar({
    required this.tabs,
    this.controller,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return TabBar(
      tabs: tabs.map((text) => _NotedTab(text: text, theme: theme)).toList(),
      controller: controller,
      isScrollable: true,
      padding: padding,
      labelPadding: EdgeInsets.zero,
      automaticIndicatorColorAdjustment: false,
      indicator: BoxDecoration(
        color: theme.colorScheme.primary,
        border: Border.all(color: theme.colorScheme.onSurface),
        borderRadius: BorderRadius.circular(18),
      ),
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 0,
      onTap: onPressed,
      splashBorderRadius: BorderRadius.circular(16),
      tabAlignment: TabAlignment.start,
    );
  }
}

class _NotedTab extends StatelessWidget {
  final String text;
  final ThemeData theme;

  const _NotedTab({required this.text, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 36,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.onSurface),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(child: Text(text, style: theme.textTheme.titleSmall)),
        ),
      ),
    );
  }
}
