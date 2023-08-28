import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
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
  final Debouncer debouncer = Debouncer(interval: const Duration(milliseconds: 500));
  late final NotedRichTextController textController;
  late final TextEditingController titleController;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    NotebookNote initial = context.read<NotebookBloc>().state.notes.firstWhere((note) => note.id == widget.noteId);
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

  void _updateNote() {
    context.read<NotebookBloc>().add(
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
    debouncer.onDispose();
    textController.dispose();
    titleController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}

class Debouncer implements Disposable {
  final Duration interval;
  Timer? _timer;

  bool get isActive => _timer?.isActive ?? false;

  Debouncer({required this.interval});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(this.interval, action);
  }

  @override
  FutureOr onDispose() {
    _timer?.cancel();
  }
}
