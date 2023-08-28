import 'package:flutter/material.dart';
import 'package:noted_app/util/extensions.dart';

class NotebookEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(context.strings().notebook_error_empty, textAlign: TextAlign.center),
      ),
    );
  }
}
