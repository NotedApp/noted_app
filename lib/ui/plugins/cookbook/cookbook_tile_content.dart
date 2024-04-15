import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

class CookbookTileContent extends StatefulWidget {
  final NoteModel note;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;

  const CookbookTileContent({required this.note, this.onPressed, this.onLongPressed, super.key});

  @override
  State<StatefulWidget> createState() => _CookbookTileContentState();
}

class _CookbookTileContentState extends State<CookbookTileContent> {
  late final NotedEditorController _textController;

  @override
  void initState() {
    super.initState();

    _textController = NotedEditorController.quill(initial: widget.note.field(NoteField.document), readonly: true);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.note.field(NoteField.link).isNotEmpty) {
      return _buildLinkedTile(context);
    } else {
      return _buildUnlinkedTile(context);
    }
  }

  Widget _buildUnlinkedTile(BuildContext context) {
    Strings strings = context.strings();
    final String prepTime = strings.cookbook_prepTime;
    final String cookTime = strings.cookbook_cookTime;

    Widget? header;

    final bool hasTitle = widget.note.field(NoteField.title).isNotEmpty;
    final bool hasTags = widget.note.field(NoteField.tagIds).isNotEmpty;
    final bool hasPrepTime = widget.note.field(NoteField.cookbookPrepTime).isNotEmpty;
    final bool hasCookTime = widget.note.field(NoteField.cookbookCookTime).isNotEmpty;

    if (hasTitle || hasTags || hasPrepTime || hasCookTime) {
      header = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          if (hasTitle)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(widget.note.field(NoteField.title), style: Theme.of(context).textTheme.titleMedium),
            ),
          if (hasTitle && hasTags) const SizedBox(height: 8),
          if (hasTags) NotedTagRow(tags: widget.note.field(NoteField.tagIds)),
          if (hasPrepTime)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
              child: Text(
                '$prepTime: ${widget.note.field(NoteField.cookbookPrepTime)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          if (hasCookTime)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
              child: Text(
                '$cookTime: ${widget.note.field(NoteField.cookbookCookTime)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
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

  Widget _buildLinkedTile(BuildContext context) {
    final strings = context.strings();
    final prepTime = strings.cookbook_prepTime;
    final cookTime = strings.cookbook_cookTime;

    final info = MediaQuery.of(context);
    final imageSize = (info.size.width * info.devicePixelRatio / 4 / NotedWidgetConfig.tileAspectRatio).round();

    final content = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          const Spacer(),
          if (widget.note.field(NoteField.title).isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.note.field(NoteField.title),
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          if (widget.note.field(NoteField.title).isNotEmpty) const SizedBox(height: 4),
          if (widget.note.field(NoteField.cookbookPrepTime).isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '$prepTime: ${widget.note.field(NoteField.cookbookPrepTime)}',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          if (widget.note.field(NoteField.cookbookCookTime).isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '$cookTime: ${widget.note.field(NoteField.cookbookCookTime)}',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: NotedLink(url: widget.note.field(NoteField.link)),
          ),
          if (widget.note.field(NoteField.tagIds).isNotEmpty) const SizedBox(height: 12),
          if (widget.note.field(NoteField.tagIds).isNotEmpty) NotedTagRow(tags: widget.note.field(NoteField.tagIds)),
        ],
      ),
    );

    if (widget.note.field(NoteField.imageUrl).isNotEmpty) {
      return Stack(
        fit: StackFit.expand,
        children: [
          NotedImage.network(
            source: widget.note.field(NoteField.imageUrl),
            fit: BoxFit.cover,
            imageHeight: imageSize,
            opacity: 0.2,
          ),
          content,
        ],
      );
    } else {
      return content;
    }
  }

  // coverage:ignore-start
  @override
  void didUpdateWidget(covariant CookbookTileContent oldWidget) {
    _textController.value = widget.note.field(NoteField.document);
    super.didUpdateWidget(oldWidget);
  }
  // coverage:ignore-end

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
