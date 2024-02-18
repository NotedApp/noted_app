import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/state/edit/edit_event.dart';
import 'package:noted_app/state/edit/edit_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/edit/edit_content.dart';
import 'package:noted_app/ui/pages/edit/edit_loading.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return NotedBlocSelector<EditBloc, EditState, (EditStatus, bool)>(
      selector: (state) => (state.status, state.note?.field(NoteField.hidden) ?? false),
      listenWhen: (previous, current) => previous.status != current.status || previous.error != current.error,
      listener: (context, state) {
        if (state.error != null) {
          _handleEditError(context, state.error);
        }

        if (state.error?.code == ErrorCode.notes_add_failed || state.status == EditStatus.deleted) {
          context.pop();
        }
      },
      builder: (context, bloc, state) {
        final status = state.$1;
        final hidden = state.$2;
        final trailingActions = <NotedIconButton>[];

        switch (status) {
          case EditStatus.loaded:
            trailingActions.addAll([
              NotedIconButton(
                icon: hidden ? NotedIcons.eyeClosed : NotedIcons.eye,
                type: NotedIconButtonType.filled,
                color: hidden ? NotedWidgetColor.tertiary : NotedWidgetColor.primary,
                size: NotedWidgetSize.small,
                onPressed: () => bloc.add(EditUpdateEvent(NoteFieldValue(NoteField.hidden, !hidden))),
              ),
              NotedIconButton(
                icon: NotedIcons.trash,
                type: NotedIconButtonType.filled,
                size: NotedWidgetSize.small,
                onPressed: () => _confirmDeleteNote(context),
              ),
            ]);
          default:
        }

        return NotedHeaderPage(
          hasBackButton: true,
          trailingActions: trailingActions,
          child: switch (status) {
            EditStatus.initial => const EditLoading(),
            EditStatus.loading => const EditLoading(),
            EditStatus.deleting => const EditLoading(),
            EditStatus.deleted => const EditLoading(),
            EditStatus.empty => NotedErrorWidget(
                text: strings.edit_error_empty,
                ctaText: strings.router_errorCta,
                ctaCallback: () => context.pop(),
              ),
            EditStatus.loaded => const EditContent(),
          },
        );
      },
    );
  }

  Future<void> _confirmDeleteNote(BuildContext context) async {
    final strings = context.strings();
    final bloc = context.read<EditBloc>();

    showDialog<bool>(
      context: context,
      builder: (context) => NotedDialog(
        leftActionText: strings.common_confirm,
        onLeftActionPressed: () {
          bloc.add(EditDeleteEvent());
          context.pop();
        },
        rightActionText: strings.common_cancel,
        onRightActionPressed: () => context.pop(),
        child: Text(strings.edit_delete_confirmText),
      ),
    );
  }

  void _handleEditError(BuildContext context, NotedError? error) {
    final strings = context.strings();

    final String? message = switch (error?.code) {
      ErrorCode.notes_add_failed => strings.edit_error_addNoteFailed,
      ErrorCode.notes_subscribe_failed => strings.edit_error_loadNoteFailed,
      ErrorCode.notes_update_failed => strings.edit_error_updateNoteFailed,
      ErrorCode.notes_delete_failed => strings.edit_error_deleteNoteFailed,
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
}
