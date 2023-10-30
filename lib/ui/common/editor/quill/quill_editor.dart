import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as Quill;
import 'package:noted_app/ui/common/editor/noted_editor.dart';
import 'package:noted_app/ui/common/editor/quill/quill_editor_controller.dart';
import 'package:noted_app/util/extensions.dart';

class QuillEditor extends NotedEditor {
  QuillEditor({
    required super.controller,
    super.focusNode,
    super.placeholder,
    super.readonly,
    super.autofocus,
    super.usePrimaryScrollController,
    super.padding,
    super.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (controller is! QuillEditorController) {
      throw ArgumentError('A quill editor must have a QuillController as its controller.');
    }

    ThemeData theme = Theme.of(context);
    Quill.QuillController quillController = (controller as QuillEditorController).controller;

    return Quill.QuillProvider(
      configurations: Quill.QuillConfigurations(controller: quillController),
      child: Quill.QuillEditor(
        scrollController: usePrimaryScrollController
            ? PrimaryScrollController.maybeOf(context) ?? ScrollController()
            : ScrollController(),
        configurations: Quill.QuillEditorConfigurations(
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
      ),
    );
  }

  bool _handleTap(TapUpDetails details, TextPosition Function(Offset) position) {
    Quill.QuillController quillController = (controller as QuillEditorController).controller;

    if (quillController.selection.baseOffset == quillController.selection.extentOffset) {
      onTap?.call();
    }

    return false;
  }
}

Quill.DefaultStyles _getStyles(BuildContext context) {
  const double defaultSize = 16;

  final ColorScheme scheme = context.colorScheme();
  final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
  final TextStyle baseStyle = defaultTextStyle.style.copyWith(
    fontSize: defaultSize,
    height: 1.3,
    decoration: TextDecoration.none,
  );
  const Quill.VerticalSpacing baseSpacing = Quill.VerticalSpacing(6, 0);

  return Quill.DefaultStyles(
    h1: Quill.DefaultTextBlockStyle(
      defaultTextStyle.style.copyWith(
        fontSize: 34,
        height: 1.15,
        fontWeight: FontWeight.w300,
        decoration: TextDecoration.none,
      ),
      const Quill.VerticalSpacing(16, 0),
      const Quill.VerticalSpacing(0, 0),
      null,
    ),
    h2: Quill.DefaultTextBlockStyle(
      defaultTextStyle.style.copyWith(
        fontSize: 24,
        height: 1.15,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none,
      ),
      const Quill.VerticalSpacing(8, 0),
      const Quill.VerticalSpacing(0, 0),
      null,
    ),
    h3: Quill.DefaultTextBlockStyle(
      defaultTextStyle.style.copyWith(
        fontSize: 20,
        height: 1.25,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      ),
      const Quill.VerticalSpacing(8, 0),
      const Quill.VerticalSpacing(0, 0),
      null,
    ),
    placeHolder: Quill.DefaultTextBlockStyle(
      baseStyle.copyWith(color: scheme.onBackground.withOpacity(0.4)),
      const Quill.VerticalSpacing(0, 0),
      const Quill.VerticalSpacing(0, 0),
      null,
    ),
    paragraph: Quill.DefaultTextBlockStyle(
      baseStyle,
      const Quill.VerticalSpacing(0, 0),
      const Quill.VerticalSpacing(0, 0),
      null,
    ),
    lists: Quill.DefaultListBlockStyle(
      baseStyle,
      const Quill.VerticalSpacing(4, 0),
      const Quill.VerticalSpacing(0, 2),
      null,
      null,
    ),
    quote: Quill.DefaultTextBlockStyle(
      TextStyle(color: scheme.onBackground.withOpacity(0.6)),
      baseSpacing,
      const Quill.VerticalSpacing(6, 2),
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
    indent: Quill.DefaultTextBlockStyle(
      baseStyle,
      baseSpacing,
      const Quill.VerticalSpacing(0, 6),
      null,
    ),
    align: Quill.DefaultTextBlockStyle(
      baseStyle,
      const Quill.VerticalSpacing(0, 0),
      const Quill.VerticalSpacing(0, 0),
      null,
    ),
    leading: Quill.DefaultTextBlockStyle(
      baseStyle,
      const Quill.VerticalSpacing(0, 0),
      const Quill.VerticalSpacing(0, 0),
      null,
    ),
  );
}
