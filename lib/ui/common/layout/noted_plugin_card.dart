import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

class NotedPluginCard extends StatelessWidget {
  final NotedPlugin plugin;
  final NotedWidgetSize size;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;

  const NotedPluginCard({
    required this.plugin,
    this.size = NotedWidgetSize.medium,
    this.onPressed,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme();
    final text = _getPluginName(context, plugin);
    final config = _NotedPluginCardConfig.fromSize(context, size);

    return SizedBox(
      width: width ?? config.width,
      height: height ?? config.height,
      child: NotedCard(
        size: config.cardSize,
        color: colors.secondary,
        onPressed: onPressed,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              width: config.width * 1.8,
              height: config.height,
              child: NotedSvg.asset(
                source: _getPluginAsset(plugin),
                fit: BoxFit.fitHeight,
                color: colors.tertiary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(text, style: config.textStyle),
            ),
          ],
        ),
      ),
    );
  }
}

String _getPluginName(BuildContext context, NotedPlugin plugin) {
  final strings = context.strings();

  return switch (plugin) {
    NotedPlugin.notebook => strings.plugin_notebook_title,
    NotedPlugin.cookbook => strings.plugin_cookbook_title,
    NotedPlugin.climbing => strings.plugin_climbing_title,
  };
}

String _getPluginAsset(NotedPlugin plugin) {
  return switch (plugin) {
    NotedPlugin.notebook => 'assets/svg/man_computer.svg',
    NotedPlugin.cookbook => 'assets/svg/woman_cooking.svg',
    NotedPlugin.climbing => 'assets/svg/woman_climbing.svg',
  };
}

class _NotedPluginCardConfig {
  final double width;
  final double height;
  final TextStyle? textStyle;
  final NotedWidgetSize cardSize;

  const _NotedPluginCardConfig._(this.width, this.height, this.textStyle, this.cardSize);

  factory _NotedPluginCardConfig.fromSize(BuildContext context, NotedWidgetSize size) {
    final text = context.textTheme();

    return switch (size) {
      NotedWidgetSize.small => _NotedPluginCardConfig._(
          102,
          32,
          text.titleSmall,
          NotedWidgetSize.small,
        ),
      NotedWidgetSize.medium => _NotedPluginCardConfig._(
          128,
          48,
          text.titleMedium,
          NotedWidgetSize.small,
        ),
      NotedWidgetSize.large => _NotedPluginCardConfig._(
          156,
          72,
          text.titleLarge,
          NotedWidgetSize.medium,
        ),
    };
  }
}
