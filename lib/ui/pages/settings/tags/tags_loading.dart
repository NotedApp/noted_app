import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';

// coverage:ignore-file
class TagsLoading extends StatelessWidget {
  const TagsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: LoadingProvider(
        child: Column(
          children: List.generate(8, (_) => const LoadingBox()),
        ),
      ),
    );
  }
}
