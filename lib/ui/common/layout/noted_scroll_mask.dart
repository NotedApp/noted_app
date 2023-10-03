import 'package:flutter/material.dart';

class NotedScrollMask extends StatelessWidget {
  final Widget child;
  final Axis direction;
  final double size;

  const NotedScrollMask({required this.direction, required this.size, required this.child});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        (Alignment, Alignment, double) params = switch (direction) {
          Axis.horizontal => (
              Alignment.centerLeft,
              Alignment.centerRight,
              bounds.width,
            ),
          Axis.vertical => (
              Alignment.topCenter,
              Alignment.bottomCenter,
              bounds.height,
            ),
        };

        double offset = size / params.$3;

        return LinearGradient(
          begin: params.$1,
          end: params.$2,
          colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
          stops: [0, offset, 1 - offset, 1],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstOut,
      child: child,
    );
  }
}
