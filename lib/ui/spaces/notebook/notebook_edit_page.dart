import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/notebook/notebook_bloc.dart';
import 'package:noted_app/state/notebook/notebook_event.dart';
import 'package:noted_app/state/notebook/notebook_state.dart';
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
    NotebookBloc bloc = context.watch();
    bool isDeleting = context.select((NotebookBloc bloc) => bloc.state.status == NotebookStatus.deleting);

    return BlocListener<NotebookBloc, NotebookState>(
      bloc: bloc,
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
            iconWidget: isDeleting == NotebookStatus.deleting ? NotedLoadingIndicator() : null,
            type: NotedIconButtonType.filled,
            size: NotedWidgetSize.small,
            onPressed: () => bloc.add(NotebookDeleteNoteEvent(noteId)),
          ),
        ],
        child: _NotebookEditContent(noteId: noteId, key: ValueKey(noteId)),
      ),
    );
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

    NotebookNote initial = context.read<NotebookBloc>().state.notes.firstWhere((note) => note.id == widget.noteId);
    textController = NotedRichTextController.quill(initial: initial.document);
    titleController = TextEditingController(text: initial.title);
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
        SizedBox(height: 8),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: NotedRichTextEditor.quill(
              controller: textController,
              focusNode: focusNode,
              placeholder: strings.notebook_edit_textPlaceholder,
            ),
          ),
        ),
        NotedRichTextToolbar(controller: textController),
      ],
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
