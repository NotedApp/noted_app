import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_catalog/catalog_list_widget.dart';

class CatalogQuillEditor extends StatefulWidget {
  const CatalogQuillEditor({super.key});

  @override
  State<StatefulWidget> createState() => _CatalogQuillEditorState();
}

class _CatalogQuillEditorState extends State<CatalogQuillEditor> {
  late final NotedEditorController _textController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _textController = NotedEditorController.quill();
  }

  @override
  Widget build(BuildContext context) {
    List<CatalogListItem> children = [
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'editor large',
        child: SizedBox(
          height: 320,
          child: NotedEditor.quill(
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
          child: NotedEditor.quill(
            controller: _textController,
            readonly: true,
          ),
        ),
      ),
    ];

    return Column(
      children: [
        Expanded(child: CatalogListWidget(children)),
        NotedEditorToolbar(controller: _textController),
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
