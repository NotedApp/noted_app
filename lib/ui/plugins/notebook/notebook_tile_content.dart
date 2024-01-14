import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_models/noted_models.dart';

class NotebookTileContent extends StatefulWidget {
  final NotebookNoteModel note;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;

  const NotebookTileContent({required this.note, this.onPressed, this.onLongPressed, super.key});

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
    Widget? header;

    final bool hasTitle = widget.note.title.isNotEmpty;
    final bool hasTags = widget.note.tagIds.isNotEmpty;

    if (hasTitle || hasTags) {
      header = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          if (hasTitle)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(widget.note.title, style: Theme.of(context).textTheme.titleMedium),
            ),
          if (hasTitle && hasTags) const SizedBox(height: 8),
          if (hasTags) NotedTagRow(tags: widget.note.tagIds)
        ],
      );
    }

    return NotedHeaderEditor(
      controller: _textController,
      readonly: true,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 36),
      onPressed: widget.onPressed,
      onLongPressed: widget.onLongPressed,
      header: header,
    );
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
