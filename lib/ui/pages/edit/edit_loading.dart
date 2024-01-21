import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';

// coverage:ignore-file
class EditLoading extends StatelessWidget {
  const EditLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LoadingProvider(
        child: Column(
          children: [
            LoadingText(
              style: context.textTheme().displaySmall,
              padding: const EdgeInsets.symmetric(vertical: 5),
            ),
            const Expanded(child: LoadingBox()),
          ],
        ),
      ),
    );
  }
}
