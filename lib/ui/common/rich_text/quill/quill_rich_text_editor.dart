import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:noted_app/ui/common/rich_text/noted_rich_text_editor.dart';
import 'package:noted_app/ui/common/rich_text/quill/quill_rich_text_controller.dart';
import 'package:noted_app/util/extensions.dart';

class QuillRichTextEditor extends NotedRichTextEditor {
  const QuillRichTextEditor({
    required super.controller,
    super.focusNode,
    super.placeholder,
    super.readonly,
    super.autofocus,
    super.padding,
    super.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (controller is! QuillRichTextController) {
      throw ArgumentError('A quill rich text editor must have a QuillController as its controller.');
    }

    ThemeData theme = Theme.of(context);
    QuillController quillController = (controller as QuillRichTextController).controller;

    return QuillProvider(
      configurations: QuillConfigurations(controller: quillController),
      child: QuillEditor(
        configurations: QuillEditorConfigurations(
          padding: padding,
          autoFocus: autofocus,
          readOnly: readonly,
          expands: true,
          placeholder: placeholder,
          showCursor: !readonly,
          keyboardAppearance: theme.brightness,
          onTapUp: _handleTap,
          customStyles: _getStyles(context),
        ),
        focusNode: focusNode ?? FocusNode(),
        scrollController: ScrollController(),
      ),
    );
  }

  bool _handleTap(TapUpDetails details, TextPosition Function(Offset) position) {
    QuillController quillController = (controller as QuillRichTextController).controller;

    if (quillController.selection.baseOffset == quillController.selection.extentOffset) {
      onTap?.call();
    }

    return false;
  }
}

DefaultStyles _getStyles(BuildContext context) {
  const double defaultSize = 16;

  final ColorScheme scheme = context.colorScheme();
  final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
  final TextStyle baseStyle = defaultTextStyle.style.copyWith(
    fontSize: defaultSize,
    height: 1.3,
    decoration: TextDecoration.none,
  );
  const VerticalSpacing baseSpacing = VerticalSpacing(6, 0);

  return DefaultStyles(
    h1: DefaultTextBlockStyle(
      defaultTextStyle.style.copyWith(
        fontSize: 34,
        height: 1.15,
        fontWeight: FontWeight.w300,
        decoration: TextDecoration.none,
      ),
      const VerticalSpacing(16, 0),
      const VerticalSpacing(0, 0),
      null,
    ),
    h2: DefaultTextBlockStyle(
      defaultTextStyle.style.copyWith(
        fontSize: 24,
        height: 1.15,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none,
      ),
      const VerticalSpacing(8, 0),
      const VerticalSpacing(0, 0),
      null,
    ),
    h3: DefaultTextBlockStyle(
      defaultTextStyle.style.copyWith(
        fontSize: 20,
        height: 1.25,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      ),
      const VerticalSpacing(8, 0),
      const VerticalSpacing(0, 0),
      null,
    ),
    placeHolder: DefaultTextBlockStyle(
      baseStyle.copyWith(color: scheme.onBackground.withOpacity(0.4)),
      const VerticalSpacing(0, 0),
      const VerticalSpacing(0, 0),
      null,
    ),
    paragraph: DefaultTextBlockStyle(
      baseStyle,
      const VerticalSpacing(0, 0),
      const VerticalSpacing(0, 0),
      null,
    ),
    lists: DefaultListBlockStyle(
      baseStyle,
      baseSpacing,
      const VerticalSpacing(0, 6),
      null,
      null,
    ),
    quote: DefaultTextBlockStyle(
      TextStyle(color: scheme.onBackground.withOpacity(0.6)),
      baseSpacing,
      const VerticalSpacing(6, 2),
      BoxDecoration(
        border: Border(
          left: BorderSide(width: 4, color: scheme.onBackground.withOpacity(0.3)),
        ),
      ),
    ),
    link: TextStyle(
      color: scheme.tertiary,
      decoration: TextDecoration.underline,
    ),
    indent: DefaultTextBlockStyle(baseStyle, baseSpacing, const VerticalSpacing(0, 6), null),
    align: DefaultTextBlockStyle(baseStyle, const VerticalSpacing(0, 0), const VerticalSpacing(0, 0), null),
    leading: DefaultTextBlockStyle(baseStyle, const VerticalSpacing(0, 0), const VerticalSpacing(0, 0), null),
  );
}
