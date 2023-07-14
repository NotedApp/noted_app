import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String _notedImageHeaderTag = 'noted-image-header';

class NotedImageHeader extends StatelessWidget {
  const NotedImageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Strings strings = Strings.of(context);
    ColorFilter filter = ColorFilter.mode(theme.colorScheme.tertiary, BlendMode.srcIn);

    return Hero(
      tag: _notedImageHeaderTag,
      child: Column(
        children: [
          Text(strings.app_title, style: theme.textTheme.displayLarge),
          SizedBox(height: 24),
          SvgPicture.asset('assets/svg/woman_reading.svg', colorFilter: filter, fit: BoxFit.fitWidth)
        ],
      ),
    );
  }
}
