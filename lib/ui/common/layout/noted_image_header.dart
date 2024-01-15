import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';

const String _notedImageHeaderTag = 'noted-image-header';

class NotedImageHeader extends StatelessWidget {
  final String? title;

  const NotedImageHeader({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme();

    return Hero(
      tag: _notedImageHeaderTag,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) const Spacer(flex: 2),
          if (title != null) Text(title!, style: theme.textTheme.displayLarge),
          const Spacer(),
          ConstrainedBox(
            constraints: BoxConstraints.loose(const Size.fromWidth(400)),
            child: NotedSvg.asset(
              source: 'assets/svg/woman_reading.svg',
              color: theme.colorScheme.tertiary,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
