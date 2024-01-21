import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';

Widget sliverHeader(
  BuildContext context,
  String text, {
  required NotedWidgetSize size,
  EdgeInsetsGeometry? padding,
}) {
  final textTheme = context.textTheme();

  final style = switch (size) {
    NotedWidgetSize.small => textTheme.headlineSmall,
    NotedWidgetSize.medium => textTheme.headlineMedium,
    NotedWidgetSize.large => textTheme.headlineLarge,
  };

  final defaultPadding = switch (size) {
    NotedWidgetSize.small => const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    NotedWidgetSize.medium => const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    NotedWidgetSize.large => const EdgeInsets.all(16),
  };

  return SliverToBoxAdapter(
    child: Padding(
      padding: padding ?? defaultPadding,
      child: Text(text, style: style),
    ),
  );
}
