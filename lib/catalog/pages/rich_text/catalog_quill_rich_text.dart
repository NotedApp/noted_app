import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_controller.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_editor.dart';
import 'package:noted_app/ui/common/rich_text/toolbar/noted_rich_text_toolbar.dart';

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
