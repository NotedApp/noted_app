import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/editor/editor.dart';

class NotedHeaderEditor extends StatelessWidget {
  final NotedEditorController controller;
  final Widget header;
  final FocusNode? focusNode;
  final String? placeholder;
  final bool readonly;
  final bool autofocus;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onPressed;

  const NotedHeaderEditor({
    required this.controller,
    required this.header,
    this.focusNode,
    this.placeholder,
    this.readonly = false,
    this.autofocus = false,
    this.padding = EdgeInsets.zero,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [SliverToBoxAdapter(child: header)],
      body: NotedEditor.quill(
        controller: controller,
        focusNode: focusNode,
        placeholder: placeholder,
        readonly: readonly,
        autofocus: autofocus,
        usePrimaryScrollController: true,
        padding: padding,
        onPressed: onPressed,
      ),
    );
  }
}
