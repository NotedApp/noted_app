import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_catalog/catalog_list_widget.dart';

class CatalogQuillRichText extends StatefulWidget {
  const CatalogQuillRichText({super.key});

  @override
  State<StatefulWidget> createState() => _CatalogQuillRichTextState();
}

class _CatalogQuillRichTextState extends State<CatalogQuillRichText> {
  late final NotedRichTextController _textController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _textController = NotedRichTextController.quill();
  }

  @override
  Widget build(BuildContext context) {
    List<CatalogListItem> children = [
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'editor large',
        child: SizedBox(
          height: 320,
          child: NotedRichTextEditor.quill(
            controller: _textController,
            focusNode: _focusNode,
            placeholder: 'enter some rich text',
          ),
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'editor readonly',
        child: SizedBox(
          height: 320,
          child: NotedRichTextEditor.quill(
            controller: _textController,
            readonly: true,
          ),
        ),
      ),
    ];

    return Column(
      children: [
        Expanded(child: CatalogListWidget(children)),
        NotedRichTextToolbar(controller: _textController),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
