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
  late final FocusNode _focusNode;
  PersistentBottomSheetController? _toolbarController;

  @override
  void initState() {
    super.initState();

    _textController = NotedRichTextController.quill();
    _focusNode = FocusNode();
    _focusNode.addListener(showToolbar);
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

    return CatalogListWidget(children);
  }

  void showToolbar() {
    if (_focusNode.context == null) {
      return;
    }

    ScaffoldState scaffoldState = Scaffold.of(_focusNode.context!);

    if (_focusNode.hasFocus && _toolbarController == null) {
      _toolbarController = scaffoldState.showBottomSheet(
        (context) => NotedRichTextToolbar(controller: _textController),
      );
    } else if (!_focusNode.hasFocus && _toolbarController != null) {
      _toolbarController!.close();
      _toolbarController = null;
    }
  }

  @override
  void dispose() {
    super.dispose();

    _focusNode.removeListener(showToolbar);
    _focusNode.dispose();
  }
}
