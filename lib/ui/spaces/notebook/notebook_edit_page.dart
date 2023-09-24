import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_event.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/spaces/notebook/notebook_page.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

class NotebookEditPage extends StatelessWidget {
  final String noteId;

  const NotebookEditPage({required this.noteId});

  @override
  Widget build(BuildContext context) {
    bool isDeleting = context.select((NotesBloc bloc) => bloc.state.status == NotesStatus.deleting);

    return BlocListener<NotesBloc, NotesState>(
      listenWhen: (previous, current) => previous.error != current.error || previous.deleted != current.deleted,
      listener: (context, state) {
        if (state.error != null) {
          handleNotebookError(context, state);
        } else if (state.deleted.isNotEmpty) {
          context.pop();
        }
      },
      child: NotedHeaderPage(
        hasBackButton: true,
        trailingActions: [
          NotedIconButton(
            icon: NotedIcons.trash,
            iconWidget: isDeleting ? NotedLoadingIndicator() : null,
            type: NotedIconButtonType.filled,
            size: NotedWidgetSize.small,
            onPressed: () => _confirmDeleteNote(context),
          ),
        ],
        child: _NotebookEditContent(noteId: noteId, key: ValueKey(noteId)),
      ),
    );
  }

  void _confirmDeleteNote(BuildContext context) async {
    Strings strings = context.strings();
    NotesBloc bloc = context.read();

    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => NotedDialog(
        child: Text(strings.notebook_delete_confirmText),
        leftActionText: strings.common_confirm,
        onLeftActionPressed: () {
          bloc.add(NotebookDeleteNoteEvent(noteId));
          context.pop(true);
        },
        rightActionText: strings.common_cancel,
        onRightActionPressed: () => context.pop(false),
      ),
    );

    if (result ?? false) {
      context.pop();
    }
  }
}

class _NotebookEditContent extends StatefulWidget {
  final String noteId;

  const _NotebookEditContent({required this.noteId, super.key});

  @override
  State<StatefulWidget> createState() => _NotebookEditContentState();
}

class _NotebookEditContentState extends State<_NotebookEditContent> {
  late final NotedRichTextController textController;
  late final TextEditingController titleController;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    NotebookNote initial = context.read<NotesBloc>().state.notes.firstWhere((note) => note.id == widget.noteId);
    textController = NotedRichTextController.quill(initial: initial.document);
    titleController = TextEditingController(text: initial.title);

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
            hint: strings.notebook_edit_titlePlaceholder,
          ),
        ),
        Expanded(
          child: NotedRichTextEditor.quill(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            controller: textController,
            focusNode: focusNode,
            placeholder: strings.notebook_edit_textPlaceholder,
            autofocus: true,
          ),
        ),
        NotedRichTextToolbar(controller: textController),
      ],
    );
  }

  void _updateNote() {
    context.read<NotesBloc>().add(
          NotebookUpdateNoteEvent(
            NotebookNote(
              id: widget.noteId,
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
