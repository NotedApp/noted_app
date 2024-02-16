import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/edit/edit_page.dart';
import 'package:noted_app/ui/pages/edit/fields/edit_text_field.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class CookbookEditContent extends StatefulWidget {
  final NoteModel note;
  final NoteUpdateCallback updateNote;

  const CookbookEditContent({required this.note, required this.updateNote, super.key});

  @override
  State<StatefulWidget> createState() => _CookbookEditContentState();
}

class _CookbookEditContentState extends State<CookbookEditContent> {
  late final NotedEditorController textController;
  late final StreamSubscription textSubscription;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    textController = NotedEditorController.quill(initial: widget.note.field(NoteField.document));
    textSubscription = textController.valueStream
        .listen((_) => widget.updateNote(NoteFieldValue(NoteField.document, textController.value)));
  }

  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();

    return Column(
      children: [
        Expanded(
          child: NotedScrollMask(
            direction: Axis.vertical,
            size: 8,
            child: NotedHeaderEditor(
              controller: textController,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
              focusNode: focusNode,
              placeholder: strings.edit_textPlaceholder,
              autofocus: true,
              header: const _CookbookEditHeader(),
            ),
          ),
        ),
        NotedEditorToolbar(controller: textController),
      ],
    );
  }

  @override
  void dispose() {
    textController.dispose();
    textSubscription.cancel();
    focusNode.dispose();
    super.dispose();
  }
}

class _CookbookEditHeader extends StatelessWidget {
  const _CookbookEditHeader();

  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditTextField.title(name: strings.edit_titlePlaceholder),
        EditTextField(field: NoteField.link, name: strings.cookbook_url),
        EditTextField(field: NoteField.imageUrl, name: strings.cookbook_imageUrl),
        EditTextField(field: NoteField.cookbookPrepTime, name: strings.cookbook_prepTime),
        EditTextField(field: NoteField.cookbookCookTime, name: strings.cookbook_cookTime),
      ],
    );
  }
}
