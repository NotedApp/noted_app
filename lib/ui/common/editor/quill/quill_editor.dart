import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:noted_app/ui/common/editor/noted_editor.dart';
import 'package:noted_app/ui/common/editor/quill/quill_editor_controller.dart';
import 'package:noted_app/util/extensions.dart';

class QuillEditor extends NotedEditor {
  const QuillEditor({
    required super.controller,
    super.focusNode,
    super.placeholder,
    super.readonly,
    super.autofocus,
    super.usePrimaryScrollController,
    super.padding,
    super.onPressed,
    super.onLongPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (controller is! QuillEditorController) {
      throw ArgumentError('A quill editor must have a QuillController as its controller.');
    }

    ThemeData theme = Theme.of(context);
    quill.QuillController quillController = (controller as QuillEditorController).controller;

    return quill.QuillEditor(
      scrollController: usePrimaryScrollController
          ? PrimaryScrollController.maybeOf(context) ?? ScrollController()
          : ScrollController(),
      configurations: quill.QuillEditorConfigurations(
        controller: quillController,
        padding: padding,
        autoFocus: autofocus,
        readOnly: readonly,
        expands: true,
        placeholder: placeholder,
        showCursor: !readonly,
        keyboardAppearance: theme.brightness,
        onTapUp: _handleTap,
        onSingleLongTapStart: _handleLongPress,
        customStyles: _getStyles(context),
      ),
      focusNode: focusNode ?? FocusNode(),
    );
  }

  bool _handleTap(TapUpDetails details, TextPosition Function(Offset) position) {
    quill.QuillController quillController = (controller as QuillEditorController).controller;

    if (quillController.selection.baseOffset == quillController.selection.extentOffset) {
      onPressed?.call();
    }

    return false;
  }

  bool _handleLongPress(LongPressStartDetails details, TextPosition Function(Offset) position) {
    if (onLongPressed != null) {
      onLongPressed!.call();
      return true;
    }

    return false;
  }
}

quill.DefaultStyles _getStyles(BuildContext context) {
  const double defaultSize = 16;

  final ColorScheme scheme = context.colorScheme();
  final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
  final TextStyle baseStyle = defaultTextStyle.style.copyWith(
    fontSize: defaultSize,
    height: 1.3,
    decoration: TextDecoration.none,
  );
  const quill.VerticalSpacing baseSpacing = quill.VerticalSpacing(6, 0);

  return quill.DefaultStyles(
    h1: quill.DefaultTextBlockStyle(
      defaultTextStyle.style.copyWith(
        fontSize: 34,
        height: 1.15,
        fontWeight: FontWeight.w300,
        decoration: TextDecoration.none,
      ),
      const quill.VerticalSpacing(16, 0),
      const quill.VerticalSpacing(0, 0),
      null,
    ),
    h2: quill.DefaultTextBlockStyle(
      defaultTextStyle.style.copyWith(
        fontSize: 24,
        height: 1.15,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none,
      ),
      const quill.VerticalSpacing(8, 0),
      const quill.VerticalSpacing(0, 0),
      null,
    ),
    h3: quill.DefaultTextBlockStyle(
      defaultTextStyle.style.copyWith(
        fontSize: 20,
        height: 1.25,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      ),
      const quill.VerticalSpacing(8, 0),
      const quill.VerticalSpacing(0, 0),
      null,
    ),
    placeHolder: quill.DefaultTextBlockStyle(
      baseStyle.copyWith(color: scheme.onBackground.withOpacity(0.4)),
      const quill.VerticalSpacing(0, 0),
      const quill.VerticalSpacing(0, 0),
      null,
    ),
    paragraph: quill.DefaultTextBlockStyle(
      baseStyle,
      const quill.VerticalSpacing(0, 0),
      const quill.VerticalSpacing(0, 0),
      null,
    ),
    lists: quill.DefaultListBlockStyle(
      baseStyle,
      const quill.VerticalSpacing(4, 0),
      const quill.VerticalSpacing(0, 2),
      null,
      null,
    ),
    quote: quill.DefaultTextBlockStyle(
      TextStyle(color: scheme.onBackground.withOpacity(0.6)),
      baseSpacing,
      const quill.VerticalSpacing(6, 2),
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
    indent: quill.DefaultTextBlockStyle(
      baseStyle,
      baseSpacing,
      const quill.VerticalSpacing(0, 6),
      null,
    ),
    align: quill.DefaultTextBlockStyle(
      baseStyle,
      const quill.VerticalSpacing(0, 0),
      const quill.VerticalSpacing(0, 0),
      null,
    ),
    leading: quill.DefaultTextBlockStyle(
      baseStyle,
      const quill.VerticalSpacing(0, 0),
      const quill.VerticalSpacing(0, 0),
      null,
    ),
  );
}
