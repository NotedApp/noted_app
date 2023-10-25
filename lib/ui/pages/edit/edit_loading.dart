import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';

class EditLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LoadingProvider(
        child: Column(
          children: [
            LoadingText(
              style: context.textTheme().displaySmall,
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
            Expanded(child: LoadingBox()),
          ],
        ),
      ),
    );
  }
}
