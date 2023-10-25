import 'package:flutter/material.dart';

class LoadingText extends StatelessWidget {
  final double? width;
  final TextStyle style;

  const LoadingText({
    this.width = null,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: style.fontSize,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
