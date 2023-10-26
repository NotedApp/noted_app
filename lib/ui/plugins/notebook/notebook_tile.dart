import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_models/noted_models.dart';

class NotebookTile extends StatefulWidget {
  final NotebookNoteModel note;
  final VoidCallback? onTap;

  const NotebookTile({required this.note, this.onTap, super.key});

  @override
  State<StatefulWidget> createState() => _NotebookTileState();
}

class _NotebookTileState extends State<NotebookTile> {
  late final NotedEditorController _textController;

  @override
  void initState() {
    super.initState();

    _textController = NotedEditorController.quill(initial: widget.note.document);
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    bool hasTitle = widget.note.title.isNotEmpty;

    if (hasTitle) {
      child = NotedHeaderEditor(
        controller: _textController,
        readonly: true,
        padding: EdgeInsets.only(bottom: 36),
        onTap: widget.onTap,
        header: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 6),
          child: Text(
            widget.note.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    } else {
      child = NotedEditor.quill(
        controller: _textController,
        readonly: true,
        padding: EdgeInsets.only(top: 12, bottom: 36),
        onTap: widget.onTap,
      );
    }

    return NotedTile(
      tags: widget.note.tags,
      onTap: widget.onTap ?? () => context.push(NotesEditRoute(noteId: widget.note.id)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: child,
      ),
    );
  }

  // coverage:ignore-start
  @override
  void didUpdateWidget(covariant NotebookTile oldWidget) {
    _textController.value = widget.note.document;
    super.didUpdateWidget(oldWidget);
  }
  // coverage:ignore-end

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
