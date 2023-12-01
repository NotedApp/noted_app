import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/edit/edit_page.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class NotebookEditContent extends StatefulWidget {
  final NotebookNoteModel note;
  final NoteUpdateCallback updateNote;

  const NotebookEditContent({required this.note, required this.updateNote, super.key});

  @override
  State<StatefulWidget> createState() => _NotebookEditContentState();
}

class _NotebookEditContentState extends State<NotebookEditContent> {
  late final NotedEditorController textController;
  late final StreamSubscription textSubscription;
  late final TextEditingController titleController;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    textController = NotedEditorController.quill(initial: widget.note.document);
    titleController = TextEditingController(text: widget.note.title);

    textSubscription = textController.valueStream.listen((_) => _updateNote());
    titleController.addListener(_updateNote);
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
              header: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: NotedTextField(
                  type: NotedTextFieldType.title,
                  controller: titleController,
                  hint: strings.edit_titlePlaceholder,
                ),
              ),
            ),
          ),
        ),
        NotedEditorToolbar(controller: textController),
      ],
    );
  }

  void _updateNote() {
    widget.updateNote(
      NotebookNoteModel(
        id: widget.note.id,
        title: titleController.text,
        document: textController.value,
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    textSubscription.cancel();
    titleController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
