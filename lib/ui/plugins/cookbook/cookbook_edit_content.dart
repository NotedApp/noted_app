import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/edit/edit_page.dart';
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
  late final TextEditingController titleController;
  late final TextEditingController linkController;
  late final TextEditingController prepTimeController;
  late final TextEditingController cookTimeController;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    textController = NotedEditorController.quill(initial: widget.note.field(NoteField.document));
    titleController = TextEditingController(text: widget.note.field(NoteField.title));
    linkController = TextEditingController(text: widget.note.field(NoteField.link));
    prepTimeController = TextEditingController(text: widget.note.field(NoteField.cookbookPrepTime));
    cookTimeController = TextEditingController(text: widget.note.field(NoteField.cookbookCookTime));

    textSubscription = textController.valueStream
        .listen((_) => widget.updateNote(NoteFieldValue(NoteField.document, textController.value)));
    titleController.addListener(() => widget.updateNote(NoteFieldValue(NoteField.title, titleController.text)));
    linkController.addListener(() => widget.updateNote(NoteFieldValue(NoteField.link, linkController.text)));
    prepTimeController.addListener(
      () => widget.updateNote(NoteFieldValue(NoteField.cookbookPrepTime, prepTimeController.text)),
    );
    cookTimeController.addListener(
      () => widget.updateNote(NoteFieldValue(NoteField.cookbookCookTime, cookTimeController.text)),
    );
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
              header: _CookbookEditHeader(
                titleController: titleController,
                linkController: linkController,
                prepTimeController: prepTimeController,
                cookTimeController: cookTimeController,
              ),
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
    titleController.dispose();
    linkController.dispose();
    prepTimeController.dispose();
    cookTimeController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}

class _CookbookEditHeader extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController linkController;
  final TextEditingController prepTimeController;
  final TextEditingController cookTimeController;

  const _CookbookEditHeader({
    required this.titleController,
    required this.linkController,
    required this.prepTimeController,
    required this.cookTimeController,
  });

  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: NotedTextField(
            type: NotedTextFieldType.title,
            controller: titleController,
            hint: strings.edit_titlePlaceholder,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: NotedTextField(
            type: NotedTextFieldType.plain,
            controller: linkController,
            name: strings.cookbook_url,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: NotedTextField(
            type: NotedTextFieldType.plain,
            controller: prepTimeController,
            name: strings.cookbook_prepTime,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: NotedTextField(
            type: NotedTextFieldType.plain,
            controller: cookTimeController,
            name: strings.cookbook_cookTime,
          ),
        ),
      ],
    );
  }
}
