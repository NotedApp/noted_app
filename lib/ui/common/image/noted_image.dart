import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NotedImage extends StatelessWidget {
  final String source;
  final BoxFit fit;
  final int? imageWidth;
  final int? imageHeight;
  final Alignment? alignment;
  final Widget? error;

  const NotedImage.network({
    super.key,
    required this.source,
    required this.fit,
    this.imageHeight,
    this.imageWidth,
    this.alignment,
    this.error,
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
    );
  }
}
