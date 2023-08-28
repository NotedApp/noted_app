import 'package:flutter/material.dart';
import 'package:noted_models/noted_models.dart';

class NotebookContent extends StatelessWidget {
  final List<NotebookNote> notes;

  NotebookContent({required this.notes});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('content'),
    );
  }
}
