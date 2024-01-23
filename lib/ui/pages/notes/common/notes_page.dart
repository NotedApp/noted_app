import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_event.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_app/util/errors/noted_exception.dart';

// coverage:ignore-file
class NotesPage extends StatelessWidget {
  final String title;
  final bool hasBackButton;
  final VoidCallback? onAdded;
  final VoidCallback? onLongAdded;
  final List<NotedIconButton>? trailingActions;
  final List<NotedIconButton>? selectingActions;
  final Widget child;

  const NotesPage({
    required this.title,
    this.hasBackButton = true,
    this.onAdded,
    this.onLongAdded,
    this.trailingActions,
    this.selectingActions,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme();

    return NotedBlocSelector<NotesBloc, NotesState, int>(
      listenWhen: (previous, current) => previous.error != current.error,
      listener: (context, state) {
        final errorCode = state.error?.code;
        final strings = context.strings();

        final message = switch (errorCode) {
          ErrorCode.notes_subscribe_failed => strings.notes_error_failed,
          ErrorCode.notes_delete_failed => strings.notes_error_deleteNoteFailed,
          _ => null
        };

        if (message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            NotedSnackBar.createWithText(context: context, text: message, hasClose: true),
          );
        }
      },
      selector: (state) => state.selectedIds.length,
      builder: (context, bloc, state) {
        final isSelecting = state > 0;
        final actions = isSelecting
            ? selectingActions ?? [_notesDeleteButton(context, bloc), _notesCancelButton(bloc)]
            : trailingActions ?? [_notesSettingsButton(context)];

        return NotedHeaderPage(
          title: isSelecting ? state.toString() : title,
          hasBackButton: hasBackButton,
          headerBackgroundColor: isSelecting ? colors.secondary : colors.background,
          trailingActions: actions,
          floatingActionButton: NotedIconButton(
            icon: NotedIcons.plus,
            type: NotedIconButtonType.filled,
            size: NotedWidgetSize.large,
            onPressed: onAdded,
            onLongPress: onAdded,
          ),
          child: child,
        );
      },
    );
  }
}

Future<void> _confirmDeleteNotes(BuildContext context, NotesBloc bloc) async {
  Strings strings = context.strings();

  showDialog<bool>(
    context: context,
    builder: (context) => NotedDialog(
      leftActionText: strings.common_confirm,
      onLeftActionPressed: () {
        bloc.add(const NotesDeleteSelectionsEvent());
        context.pop();
      },
      rightActionText: strings.common_cancel,
      onRightActionPressed: () => context.pop(),
      child: Text(strings.notes_delete_confirmText),
    ),
  );
}

NotedIconButton _notesDeleteButton(BuildContext context, NotesBloc bloc) {
  return NotedIconButton(
    icon: NotedIcons.trash,
    type: NotedIconButtonType.filled,
    size: NotedWidgetSize.small,
    color: NotedWidgetColor.tertiary,
    onPressed: () => _confirmDeleteNotes(context, bloc),
  );
}

NotedIconButton _notesCancelButton(NotesBloc bloc) {
  return NotedIconButton(
    icon: NotedIcons.close,
    type: NotedIconButtonType.simple,
    onPressed: () => bloc.add(const NotesResetSelectionsEvent()),
  );
}

NotedIconButton _notesSettingsButton(BuildContext context) {
  return NotedIconButton(
    icon: NotedIcons.settings,
    type: NotedIconButtonType.filled,
    size: NotedWidgetSize.small,
    onPressed: () => context.push(SettingsRoute()),
  );
}
