import 'dart:math';

import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';

// coverage:ignore-file
class LoadingText extends StatelessWidget {
  final double? width;
  final TextStyle? style;
  final EdgeInsetsGeometry padding;

  const LoadingText({
    super.key,
    this.width,
    required this.style,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry heightPadding = EdgeInsets.symmetric(
      vertical: max((style?.height ?? 0) - 1, 0) * (style?.fontSize ?? 0) / 2,
    );

    return LoadingBox(
      width: width,
      height: style?.fontSize,
      padding: padding.add(heightPadding),
    );
  }
}
