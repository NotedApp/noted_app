import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';

class NotebookEditPage extends StatefulWidget {
  final String noteId;

  const NotebookEditPage({required this.noteId});

  @override
  State<StatefulWidget> createState() => _NotebookEditPageState();
}

class _NotebookEditPageState extends State<NotebookEditPage> {
  @override
  Widget build(BuildContext context) {
    return NotedHeaderPage(
      hasBackButton: true,
      child: Center(child: Text('hello world: ${widget.noteId}')),
    );
  }
}
