import 'package:flutter/material.dart';

class LoadingBox extends StatelessWidget {
  final double cornerRadius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;

  const LoadingBox({
    this.cornerRadius = 12,
    this.width = null,
    this.height = null,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
      ),
    );
  }
}
