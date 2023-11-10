import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_models/noted_models.dart';

class NotebookTileContent extends StatefulWidget {
  final NotebookNoteModel note;
  final VoidCallback? onPressed;

  const NotebookTileContent({required this.note, this.onPressed, super.key});

  @override
  State<StatefulWidget> createState() => _NotebookTileContentState();
}

class _NotebookTileContentState extends State<NotebookTileContent> {
  late final NotedEditorController _textController;

  @override
  void initState() {
    super.initState();

    _textController = NotedEditorController.quill(initial: widget.note.document);
  }

  @override
  Widget build(BuildContext context) {
    bool hasTitle = widget.note.title.isNotEmpty;

    if (hasTitle) {
      return NotedHeaderEditor(
        controller: _textController,
        readonly: true,
        padding: EdgeInsets.only(top: 12, bottom: 36),
        onPressed: widget.onPressed,
        header: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
          child: Text(
            widget.note.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    } else {
      return NotedEditor.quill(
        controller: _textController,
        readonly: true,
        padding: EdgeInsets.only(top: 12, bottom: 36),
        onPressed: widget.onPressed,
      );
    }
  }

  // coverage:ignore-start
  @override
  void didUpdateWidget(covariant NotebookTileContent oldWidget) {
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
