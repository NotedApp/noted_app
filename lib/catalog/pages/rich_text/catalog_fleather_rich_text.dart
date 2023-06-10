import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_controller.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_editor.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_toolbar.dart';

class CatalogFleatherRichText extends StatefulWidget {
  const CatalogFleatherRichText({super.key});

  @override
  State<StatefulWidget> createState() => _CatalogFleatherRichTextState();
}

class _CatalogFleatherRichTextState extends State<CatalogFleatherRichText> {
  late NotedRichTextController _textController;
  late FocusNode _focusNode;
  PersistentBottomSheetController? _toolbarController;

  @override
  void initState() {
    super.initState();

    _textController = NotedRichTextController.fleather();
    _focusNode = FocusNode();
    _focusNode.addListener(showToolbar);
  }

  @override
  Widget build(BuildContext context) {
    List<CatalogListItem> children = [
      CatalogListItem(
        type: CatalogListItemType.column,
        label: "editor large",
        child: SizedBox(
          height: 320,
          child: NotedRichTextEditor.fleather(
            _textController,
            _focusNode,
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
      _toolbarController = scaffoldState.showBottomSheet((context) => NotedRichTextToolbar.fleather(_textController));
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
