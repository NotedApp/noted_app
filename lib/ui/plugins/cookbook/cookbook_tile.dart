import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_models/noted_models.dart';

// TODO: Update this to be specific to the cookbook plugin.
class CookbookTile extends StatefulWidget {
  final CookbookNoteModel note;
  final VoidCallback? onPressed;

  const CookbookTile({required this.note, this.onPressed, super.key});

  @override
  State<StatefulWidget> createState() => _CookbookTileState();
}

class _CookbookTileState extends State<CookbookTile> {
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
      child = NotedEditor.quill(
        controller: _textController,
        readonly: true,
        padding: EdgeInsets.only(top: 12, bottom: 36),
        onPressed: widget.onPressed,
      );
    }

    return NotedTile(
      tags: widget.note.tagIds,
      onPressed: widget.onPressed ?? () => context.push(NotesEditRoute(noteId: widget.note.id)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: child,
      ),
    );
  }

  // coverage:ignore-start
  @override
  void didUpdateWidget(covariant CookbookTile oldWidget) {
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
