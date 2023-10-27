import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_models/noted_models.dart';

class NotebookNoteModelTile extends StatefulWidget {
  final NotebookNoteModel note;
  final VoidCallback? onTap;

  const NotebookNoteModelTile({required this.note, this.onTap, super.key});

  @override
  State<StatefulWidget> createState() => _NotebookNoteModelTileState();
}

class _NotebookNoteModelTileState extends State<NotebookNoteModelTile> {
  late final NotedEditorController _textController;

  @override
  void initState() {
    super.initState();

    _textController = NotedEditorController.quill(initial: widget.note.document);
  }

  @override
  Widget build(BuildContext context) {
    return NotedTile(
      child: Container(
        padding: EdgeInsets.only(
          left: 12,
          top: widget.note.title.isNotEmpty ? 12 : 0,
          right: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.note.title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  widget.note.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            Expanded(
              child: NotedEditor.quill(
                controller: _textController,
                readonly: true,
                padding: EdgeInsets.only(
                  top: widget.note.title.isNotEmpty ? 0 : 12,
                  bottom: 12,
                ),
                onTap: widget.onTap,
              ),
            ),
          ],
        ),
      ),
      onTap: widget.onTap ?? () => context.push('notes/${widget.note.id}'),
    );
  }

  // coverage:ignore-start
  @override
  void didUpdateWidget(covariant NotebookNoteModelTile oldWidget) {
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
