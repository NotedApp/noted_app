import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/state/edit/edit_event.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

class NotebookEditContent extends StatefulWidget {
  final NotebookNoteModel note;

  const NotebookEditContent({required this.note, super.key});

  @override
  State<StatefulWidget> createState() => _NotebookEditContentState();
}

class _NotebookEditContentState extends State<NotebookEditContent> {
  late final NotedEditorController textController;
  late final TextEditingController titleController;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    textController = NotedEditorController.quill(initial: widget.note.document);
    titleController = TextEditingController(text: widget.note.title);

    textController.addListener(_updateNote);
    titleController.addListener(_updateNote);
  }

  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();

    return Column(
      children: [
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: NotedTextField(
            type: NotedTextFieldType.title,
            controller: titleController,
            hint: strings.edit_titlePlaceholder,
          ),
        ),
        Expanded(
          child: NotedEditor.quill(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            controller: textController,
            focusNode: focusNode,
            placeholder: strings.edit_textPlaceholder,
            autofocus: true,
          ),
        ),
        NotedEditorToolbar(controller: textController),
      ],
    );
  }

  void _updateNote() {
    context.read<EditBloc>().add(
          EditUpdateEvent(
            NotebookNoteModel(
              id: widget.note.id,
              title: titleController.text,
              document: textController.value,
            ),
          ),
        );
  }

  @override
  void dispose() {
    textController.dispose();
    titleController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
