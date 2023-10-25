import 'package:flutter/material.dart';

class LoadingBox extends StatelessWidget {
  final double cornerRadius;
  final double? width;
  final double? height;

  const LoadingBox({
    this.cornerRadius = 12,
    this.width = null,
    this.height = null,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
    );
  }
}
