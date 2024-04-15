import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';

class EditImageField extends StatelessWidget {
  final String imageUrl;

  const EditImageField({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final background = context.colorScheme().surface;

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

class EditImageHeader extends StatelessWidget {
  final String imageUrl;
  final Widget child;

  const EditImageHeader({required this.imageUrl, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return child;
    }

    final width = MediaQuery.of(context).size.width / NotedWidgetConfig.goldenRatio;

    return Stack(
      children: [
        EditImageField(imageUrl: imageUrl),
        Padding(padding: EdgeInsets.only(top: width * 2 / 3), child: child),
      ],
    );
  }
}
