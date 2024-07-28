import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';

class NotedTemplateCard extends StatelessWidget {
  final String name;
  final NotedWidgetSize size;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;

  const NotedTemplateCard({
    required this.name,
    this.size = NotedWidgetSize.medium,
    this.onPressed,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme();
    final config = _NotedPluginCardConfig.fromSize(context, size);

    return SizedBox(
      width: width ?? config.width,
      height: height ?? config.height,
      child: NotedCard(
        size: config.cardSize,
        color: colors.secondary,
        onPressed: onPressed,
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing_m),
            child: Text(name, style: config.textStyle),
          ),
        ),
      ),
    );
  }
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
