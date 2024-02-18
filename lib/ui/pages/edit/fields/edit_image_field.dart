import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';

class EditImageField extends StatelessWidget {
  final String imageUrl;

  const EditImageField({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final background = context.colorScheme().background;

    return AspectRatio(
      aspectRatio: NotedWidgetConfig.goldenRatio,
      child: Container(
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [background.withAlpha(0), background],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: NotedImage.network(source: imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}
