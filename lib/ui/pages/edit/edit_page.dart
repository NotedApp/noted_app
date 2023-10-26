import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/state/edit/edit_event.dart';
import 'package:noted_app/state/edit/edit_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/edit/edit_content.dart';
import 'package:noted_app/ui/pages/edit/edit_loading.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_app/util/extensions.dart';

class EditPage extends StatelessWidget {
  final String? initialId;

  const EditPage({required this.initialId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditBloc(noteId: initialId),
      child: BlocConsumer<EditBloc, EditState>(
        listenWhen: (previous, current) => previous.status != current.status || previous.error != current.error,
        listener: (context, state) {
          if (state.error != null) {
            _handleEditError(context, state.error);
          }

          if (state.error?.code == ErrorCode.notes_add_failed || state.status == EditStatus.deleted) {
            context.pop();
          }
        },
        builder: (context, state) {
          return NotedHeaderPage(
            hasBackButton: true,
            trailingActions: [
              if (state.note != null)
                NotedIconButton(
                  icon: NotedIcons.trash,
                  type: NotedIconButtonType.filled,
                  size: NotedWidgetSize.small,
                  onPressed: () => _confirmDeleteNote(context),
                ),
            ],
            child: switch (state) {
              EditState(status: EditStatus.initial) => EditLoading(),
              EditState(status: EditStatus.loading) => EditLoading(),
              EditState(status: EditStatus.deleting) => EditLoading(),
              EditState(status: EditStatus.deleted) => EditLoading(),
              EditState(note: null) => EditLoading(), // TODO: Make this edit empty.
              _ => EditContent(note: state.note!),
            },
          );
        },
      ),
    );
  }

  void _confirmDeleteNote(BuildContext context) async {
    Strings strings = context.strings();
    EditBloc bloc = context.read();

    showDialog<bool>(
      context: context,
      builder: (context) => NotedDialog(
        child: Text(strings.notes_delete_confirmText),
        leftActionText: strings.common_confirm,
        onLeftActionPressed: () {
          bloc.add(EditDeleteEvent());
          context.pop();
        },
        rightActionText: strings.common_cancel,
        onRightActionPressed: () => context.pop(),
      ),
    );
  }
}

void _handleEditError(BuildContext context, NotedError? error) {
  Strings strings = context.strings();

  final String? message = switch (error?.code) {
    ErrorCode.notes_add_failed => strings.notes_error_addNoteFailed,
    ErrorCode.notes_update_failed => strings.notes_error_updateNoteFailed,
    ErrorCode.notes_delete_failed => strings.notes_error_deleteNoteFailed,
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
