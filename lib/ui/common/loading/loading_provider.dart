import 'package:flutter/material.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:shimmer/shimmer.dart';

// coverage:ignore-file
class LoadingProvider extends StatelessWidget {
  final Widget child;

  const LoadingProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme();

    return Shimmer.fromColors(
      baseColor: theme.shimmerBase(),
      highlightColor: theme.shimmerHighlight(),
      child: child,
    );
  }
}
