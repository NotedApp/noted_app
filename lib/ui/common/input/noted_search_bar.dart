import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';

class NotedSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onCancel;

  const NotedSearchBar({required this.controller, this.onCancel, super.key});

  @override
  State<StatefulWidget> createState() => _NotedSearchBarState();
}

class _NotedSearchBarState extends State<NotedSearchBar> {
  final focusNode = FocusNode();

  var isSearching = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onUpdate);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    final icon = isSearching ? NotedIcons.close : NotedIcons.search;
    final onIconPressed = isSearching ? onCancel : null;

    return NotedTextField(
      controller: widget.controller,
      focusNode: focusNode,
      hint: strings.common_search_placeholder,
      type: NotedTextFieldType.outlined,
      icon: icon,
      onIconPressed: onIconPressed,
    );
  }

  void onUpdate() {
    if (widget.controller.text.isEmpty && isSearching) {
      setState(() => isSearching = false);
    } else if (widget.controller.text.isNotEmpty && !isSearching) {
      setState(() => isSearching = true);
    }
  }

  void onCancel() {
    widget.onCancel?.call();
    focusNode.unfocus();
    widget.controller.clear();
  }

  @override
  void dispose() {
    widget.controller.removeListener(onUpdate);
    focusNode.dispose();
    super.dispose();
  }
}
