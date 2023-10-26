import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

enum _NotedTagType {
  normal,
  add,
  delete,
}

class NotedTag extends StatelessWidget {
  final _NotedTagType _type;
  final NotedWidgetSize size;
  final String text;
  final Color color;
  final VoidCallback? onTap;

  NotedTag({required this.size, required TagModel model, this.onTap = null})
      : _type = _NotedTagType.normal,
        text = model.name,
        color = Color(model.color);

  const NotedTag.custom({
    required this.size,
    required this.text,
    required this.color,
    this.onTap = null,
  }) : _type = _NotedTagType.normal;

  NotedTag.add({required this.size, this.onTap = null})
      : _type = _NotedTagType.add,
        text = '',
        color = Colors.transparent;

  NotedTag.delete({required this.size, required TagModel model, this.onTap = null})
      : _type = _NotedTagType.delete,
        text = model.name,
        color = Color(model.color);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme();

    (Color, Color) colors = switch (_type) {
      _NotedTagType.normal => (
          color,
          color.withAlpha(52),
        ),
      _NotedTagType.add => (
          theme.colorScheme.onBackground.withAlpha(128),
          theme.colorScheme.onBackground.withAlpha(52),
        ),
      _NotedTagType.delete => (
          color,
          color.withAlpha(52),
        ),
    };

    (TextStyle?, EdgeInsetsGeometry, double, double) params = switch (size) {
      NotedWidgetSize.large => (
          theme.textTheme.bodyMedium?.copyWith(color: colors.$1),
          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          16,
          14,
        ),
      NotedWidgetSize.medium => (
          theme.textTheme.labelLarge?.copyWith(color: colors.$1),
          const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          14,
          12,
        ),
      NotedWidgetSize.small => (
          theme.textTheme.labelSmall?.copyWith(color: colors.$1),
          const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          12,
          10,
        ),
    };

    Widget tag = Container(
      decoration: BoxDecoration(
        color: colors.$2,
        border: Border.all(color: colors.$1),
        borderRadius: BorderRadius.circular(params.$4),
      ),
      padding: params.$2,
      child: switch (_type) {
        _NotedTagType.normal => Text(text, style: params.$1),
        _NotedTagType.add => Row(
            children: [
              Icon(NotedIcons.plus, size: params.$3, color: colors.$1),
              SizedBox(width: 2),
              Text(context.strings().tags_addTag, style: params.$1),
            ],
          ),
        _NotedTagType.delete => Row(
            children: [
              Text(text, style: params.$1),
              SizedBox(width: 2),
              Icon(NotedIcons.trash, size: params.$3, color: colors.$1),
            ],
          ),
      },
    );

    return onTap == null
        ? tag
        : InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(params.$4),
            child: tag,
          );
  }
}
