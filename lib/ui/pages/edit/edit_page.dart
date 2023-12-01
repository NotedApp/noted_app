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
import 'package:noted_app/util/debouncer.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

const int _updateDebounceTimeMs = 250;

typedef NoteUpdateCallback = void Function(NoteModel);

// coverage:ignore-file
class EditPage extends StatelessWidget {
  final EditBloc bloc;
  final Debouncer updateDebouncer = Debouncer(interval: const Duration(milliseconds: _updateDebounceTimeMs));

  EditPage({super.key, required String initialId}) : bloc = EditBloc(noteId: initialId);

  EditPage.add({super.key, required NotedPlugin plugin}) : bloc = EditBloc.add(plugin: plugin);

  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();

    return BlocProvider(
      create: (context) => bloc,
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
          void updateNote(NoteModel note) {
            updateDebouncer.run(() => context.read<EditBloc>().add(EditUpdateEvent(note)));
          }

          return NotedHeaderPage(
            hasBackButton: true,
            backButton: StreamBuilder(
              stream: updateDebouncer.activeStream,
              initialData: false,
              builder: (context, value) => _EditBackButton(isSaving: value.hasData ? value.data! : false),
            ),
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
              EditState(status: EditStatus.initial) => const EditLoading(),
              EditState(status: EditStatus.loading) => const EditLoading(),
              EditState(status: EditStatus.deleting) => const EditLoading(),
              EditState(status: EditStatus.deleted) => const EditLoading(),
              EditState(note: null) => NotedErrorWidget(
                  text: strings.edit_error_empty,
                  ctaText: strings.router_errorCta,
                  ctaCallback: () => context.pop(),
                ),
              _ => EditContent(note: state.note!, updateNote: updateNote),
            },
          );
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

class _EditBackButton extends StatelessWidget {
  final bool isSaving;

  const _EditBackButton({required this.isSaving});

  @override
  Widget build(BuildContext context) {
    return NotedIconButton(
      icon: NotedIcons.chevronLeft,
      iconWidget: isSaving ? NotedLoadingIndicator(size: 14, color: context.colorScheme().onPrimary) : null,
      type: NotedIconButtonType.filled,
      size: NotedWidgetSize.small,
      onPressed: () => context.pop(),
    );
  }
}
