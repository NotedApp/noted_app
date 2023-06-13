import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_controller.dart';
import 'package:noted_app/widget/common/rich_text/noted_rich_text_editor.dart';

class CatalogAppflowyRichText extends StatefulWidget {
  const CatalogAppflowyRichText({super.key});

  @override
  State<StatefulWidget> createState() => _CatalogAppflowyRichTextState();
}

class _CatalogAppflowyRichTextState extends State<CatalogAppflowyRichText> {
  late NotedRichTextController _textController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _textController = NotedRichTextController.appflowy();
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
          child: NotedRichTextEditor.appflowy(
            _textController,
            _focusNode,
          ),
        ),
      ),
    ];

    return CatalogListWidget(children);
  }

  void showToolbar() {
    /*if (_focusNode.context == null) {
      return;
    }

    ScaffoldState scaffoldState = Scaffold.of(_focusNode.context!);

    if (_focusNode.hasFocus && _toolbarController == null) {
      _toolbarController = scaffoldState.showBottomSheet((context) => NotedRichTextToolbar.appflowy(_textController));
    } else if (!_focusNode.hasFocus && _toolbarController != null) {
      _toolbarController!.close();
      _toolbarController = null;
    }*/
  }

  @override
  void dispose() {
    super.dispose();

    _focusNode.removeListener(showToolbar);
    _focusNode.dispose();
  }
}
