import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/notebook/notebook_bloc.dart';
import 'package:noted_app/state/notebook/notebook_event.dart';
import 'package:noted_app/state/notebook/notebook_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/spaces/notebook/notebook_content.dart';
import 'package:noted_app/ui/spaces/notebook/notebook_empty.dart';
import 'package:noted_app/ui/spaces/notebook/notebook_error.dart';
import 'package:noted_app/ui/spaces/notebook/notebook_loading.dart';
import 'package:noted_app/util/debouncer.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

class NotebookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
  final Debouncer debouncer = Debouncer(interval: const Duration(milliseconds: 500));

  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();
    NotebookBloc bloc = context.watch();

    VoidCallback addNote = () => debouncer.run(() => bloc.add(NotebookAddNoteEvent(NotebookNote.emptyQuill())));

    return BlocConsumer<NotebookBloc, NotebookState>(
      bloc: bloc,
      listenWhen: (previous, current) => previous.error != current.error || previous.added != current.added,
      listener: (context, state) {
        if (state.error != null) {
          handleNotebookError(context, state);
        } else if (state.added.isNotEmpty) {
          context.push('/notebook/${state.added}');
        }
      },
      builder: (context, state) => NotedHeaderPage(
        title: strings.notebook_title,
        hasBackButton: false,
        trailingActions: [
          NotedIconButton(
            icon: NotedIcons.settings,
            type: NotedIconButtonType.filled,
            size: NotedWidgetSize.small,
            onPressed: () => context.push('/settings'),
          ),
        ],
        floatingActionButton: NotedIconButton(
          icon: NotedIcons.plus,
          type: NotedIconButtonType.filled,
          size: NotedWidgetSize.large,
          onPressed: state.status != NotebookStatus.adding ? addNote : null,
        ),
        child: switch (state) {
          NotebookState(status: NotebookStatus.loading) => NotebookLoading(),
          NotebookState(error: NotedException(code: ErrorCode.notebook_subscribe_failed)) => NotebookError(),
          NotebookState(notes: []) => NotebookEmpty(),
          _ => NotebookContent(notes: state.notes),
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

void handleNotebookError(BuildContext context, NotebookState state) {
  Strings strings = context.strings();

  final String? message = switch (state.error?.code) {
    ErrorCode.notebook_add_failed => strings.notebook_error_addNoteFailed,
    ErrorCode.notebook_update_failed => strings.notebook_error_updateNoteFailed,
    ErrorCode.notebook_delete_failed => strings.notebook_error_deleteNoteFailed,
    _ => null,
  };

  if (message != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      NotedSnackBar.createWithText(
        context: context,
        text: message,
        hasClose: true,
      ),
    );
  }
}
