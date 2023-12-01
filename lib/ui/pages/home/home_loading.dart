import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';

// coverage:ignore-file
class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: LoadingProvider(
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: NotedWidgetConfig.tileAspectRatio,
          children: List.filled(8, const LoadingBox()),
        ),
      ),
    );
  }
}
