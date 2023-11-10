import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_models/noted_models.dart';

// TODO: Update this to be specific to the cookbook plugin.
class CookbookTileContent extends StatefulWidget {
  final CookbookNoteModel note;
  final VoidCallback? onPressed;

  const CookbookTileContent({required this.note, this.onPressed, super.key});

  @override
  State<StatefulWidget> createState() => _CookbookTileContentState();
}

class _CookbookTileContentState extends State<CookbookTileContent> {
  late final NotedEditorController _textController;

  @override
  void initState() {
    super.initState();

    _textController = NotedEditorController.quill(initial: widget.note.document);
  }

  @override
  Widget build(BuildContext context) {
    Widget? header;
    final List<Widget> children = [];

    if (widget.note.title.isNotEmpty) {
      children.addAll([
        Text(widget.note.title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 12),
      ]);
    }

    if (widget.note.prepTime.isNotEmpty) {
      children.addAll([
        Text(widget.note.prepTime, style: Theme.of(context).textTheme.bodySmall),
        SizedBox(height: 12),
      ]);
    }

    if (widget.note.cookTime.isNotEmpty) {
      children.addAll([
        Text(widget.note.cookTime, style: Theme.of(context).textTheme.bodySmall),
        SizedBox(height: 12),
      ]);
    }

    if (children.isNotEmpty) {
      header = Padding(
        padding: EdgeInsets.only(top: 12),
        child: Column(children: children),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: NotedHeaderEditor(
        controller: _textController,
        readonly: true,
        padding: EdgeInsets.only(top: 12, bottom: 36),
        onPressed: widget.onPressed,
        header: header,
      ),
    );
  }

  // coverage:ignore-start
  @override
  void didUpdateWidget(covariant CookbookTileContent oldWidget) {
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
