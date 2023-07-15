import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noted_app/util/extensions.dart';

const String _notedImageHeaderTag = 'noted-image-header';

class NotedImageHeader extends StatelessWidget {
  final String? title;

  const NotedImageHeader({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme();
    ColorFilter filter = ColorFilter.mode(theme.colorScheme.tertiary, BlendMode.srcIn);

    return Hero(
      tag: _notedImageHeaderTag,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) Spacer(flex: 2),
          if (title != null) Text(title!, style: theme.textTheme.displayLarge),
          Spacer(),
          ConstrainedBox(
            constraints: BoxConstraints.loose(Size.fromWidth(400)),
            child: SvgPicture.asset(
              'assets/svg/woman_reading.svg',
              colorFilter: filter,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
