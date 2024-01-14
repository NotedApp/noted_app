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
import 'package:noted_models/noted_models.dart';

typedef NoteUpdateCallback = void Function(NoteModel);

// coverage:ignore-file
class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();

    return NotedBlocSelector<EditBloc, EditState, EditStatus>(
      selector: (state) => state.status,
      listenWhen: (previous, current) => previous.status != current.status || previous.error != current.error,
      listener: (context, state) {
        if (state.error != null) {
          _handleEditError(context, state.error);
        }

        if (state.error?.code == ErrorCode.notes_add_failed || state.status == EditStatus.deleted) {
          context.pop();
        }
      },
      builder: (context, bloc, status) => NotedHeaderPage(
        hasBackButton: true,
        trailingActions: [
          if (status == EditStatus.loaded)
            NotedIconButton(
              icon: NotedIcons.trash,
              type: NotedIconButtonType.filled,
              size: NotedWidgetSize.small,
              onPressed: () => _confirmDeleteNote(context),
            ),
        ],
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
      ),
    );
  }

  Future<void> _confirmDeleteNote(BuildContext context) async {
    Strings strings = context.strings();
    EditBloc bloc = context.read();

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
    Strings strings = context.strings();

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
