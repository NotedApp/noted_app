import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/noted_library.dart';
import 'package:noted_models/noted_models.dart';

class NotebookNoteTile extends StatefulWidget {
  final NotebookNote note;

  const NotebookNoteTile({required this.note, super.key});

  @override
  State<StatefulWidget> createState() => _NotebookNoteTileState();
}

class _NotebookNoteTileState extends State<NotebookNoteTile> {
  late NotedRichTextController _textController;

  @override
  void initState() {
    super.initState();

    _textController = NotedRichTextController.quill(initial: widget.note.document);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color surface = theme.colorScheme.surface;
    Color surfaceTransparent = surface.withOpacity(0);

    return NotedTile(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 8, 12, 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.85, 1],
            colors: [surfaceTransparent, surfaceTransparent, surface],
          ),
        ),
        child: Column(
          children: [
            if (widget.note.title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(widget.note.title, style: theme.textTheme.titleMedium),
              ),
            NotedRichTextEditor.quill(
              controller: _textController,
              readonly: true,
            ),
          ],
        ),
      ),
      // TODO: Implement real navigation here.
      onTap: () => Navigator.of(context).pushNamed('notes/${widget.note.id}'),
    );
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }
}
