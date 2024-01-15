import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';
import 'package:ogp_data_extract/ogp_data_extract.dart';

class CookbookTileContent extends StatefulWidget {
  final CookbookNoteModel note;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;

  const CookbookTileContent({required this.note, this.onPressed, this.onLongPressed, super.key});

  @override
  State<StatefulWidget> createState() => _CookbookTileContentState();
}

class _CookbookTileContentState extends State<CookbookTileContent> {
  late final NotedEditorController _textController;
  late final Future<String?> _imageUrl;

  @override
  void initState() {
    super.initState();

    _textController = NotedEditorController.quill(initial: widget.note.document);
    _imageUrl = _getOgpImage(widget.note.url);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.note.url.isNotEmpty) {
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

    final bool hasTitle = widget.note.title.isNotEmpty;
    final bool hasTags = widget.note.tagIds.isNotEmpty;
    final bool hasPrepTime = widget.note.prepTime.isNotEmpty;
    final bool hasCookTime = widget.note.cookTime.isNotEmpty;

    if (hasTitle || hasTags || hasPrepTime || hasCookTime) {
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
          if (hasTags) NotedTagRow(tags: widget.note.tagIds),
          if (hasPrepTime)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
              child: Text('$prepTime: ${widget.note.prepTime}', style: Theme.of(context).textTheme.bodyMedium),
            ),
          if (hasCookTime)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
              child: Text('$cookTime: ${widget.note.cookTime}', style: Theme.of(context).textTheme.bodyMedium),
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

    return Stack(
      fit: StackFit.expand,
      children: [
        FutureBuilder(
          future: _imageUrl,
          builder: (context, snapshot) {
            if (snapshot.hasData && (snapshot.data?.isNotEmpty ?? false)) {
              // coverage:ignore-start
              return Opacity(
                opacity: 0.2,
                child: NotedImage.network(
                  source: snapshot.data!,
                  fit: BoxFit.cover,
                  imageHeight: imageSize,
                ),
              );
              // coverage:ignore-end
            } else {
              return Container();
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              const Spacer(),
              if (widget.note.title.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    widget.note.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              if (widget.note.title.isNotEmpty) const SizedBox(height: 4),
              if (widget.note.prepTime.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '$prepTime: ${widget.note.prepTime}',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              if (widget.note.cookTime.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '$cookTime: ${widget.note.cookTime}',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: NotedLink(url: widget.note.url),
              ),
              if (widget.note.tagIds.isNotEmpty) const SizedBox(height: 12),
              if (widget.note.tagIds.isNotEmpty) NotedTagRow(tags: widget.note.tagIds)
            ],
          ),
        ),
      ],
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

  Future<String?> _getOgpImage(String url) async {
    final OgpData? ogpData = await OgpDataExtract.execute(url);
    return ogpData?.image; // coverage:ignore-line
  }
}
