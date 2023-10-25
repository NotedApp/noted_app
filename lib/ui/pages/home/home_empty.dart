import 'package:flutter/material.dart';
import 'package:noted_app/util/extensions.dart';

class HomeEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Text(context.strings().notes_error_empty, textAlign: TextAlign.center),
      ),
    );
  }
}
