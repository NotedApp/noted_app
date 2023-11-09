import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noted_app/util/extensions.dart';

class NotedSvg extends StatelessWidget {
  final String source;
  final BoxFit fit;
  final Color? color;

  const NotedSvg.asset({required this.source, required this.fit, this.color = null});

  @override
  Widget build(BuildContext context) {
    ColorFilter filter = ColorFilter.mode(color ?? context.colorScheme().onBackground, BlendMode.srcIn);

    return SvgPicture.asset(source, colorFilter: filter, fit: fit);
  }
}