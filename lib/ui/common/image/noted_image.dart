import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NotedImage extends StatelessWidget {
  final String source;
  final BoxFit fit;
  final int? imageWidth;
  final int? imageHeight;
  final Alignment? alignment;
  final double opacity;

  const NotedImage.network({
    super.key,
    required this.source,
    required this.fit,
    this.imageHeight,
    this.imageWidth,
    this.alignment,
    this.opacity = 1,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: source,
      fit: fit,
      memCacheWidth: imageWidth,
      maxWidthDiskCache: imageWidth,
      memCacheHeight: imageHeight,
      maxHeightDiskCache: imageHeight,
      alignment: alignment ?? Alignment.center,
      color: opacity == 1 ? null : Color.fromRGBO(255, 255, 255, opacity),
      colorBlendMode: opacity == 1 ? null : BlendMode.modulate,
    );
  }
}
