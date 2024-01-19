import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/home/home_bloc.dart';
import 'package:noted_app/state/home/home_event.dart';
import 'package:noted_app/state/home/home_state.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/home/home_frame.dart';
import 'package:noted_app/ui/pages/home/note_picker/note_picker.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();
    ColorScheme colors = context.colorScheme();

    return NotedBlocSelector<HomeBloc, HomeState, Set<String>>(
      listenWhen: (previous, current) => previous.error != current.error,
      listener: (context, state) {
        if (state.error?.code == ErrorCode.notes_delete_failed) {
          ScaffoldMessenger.of(context).showSnackBar(
            NotedSnackBar.createWithText(
              context: context,
              text: strings.notes_error_deleteNoteFailed,
              hasClose: true,
            ),
          );
        }
      },
      selector: (state) => state.selectedIds,
      builder: (context, bloc, state) {
        final isSelecting = state.isNotEmpty;

        List<NotedIconButton> trailingActions = isSelecting
            ? [
                NotedIconButton(
                  icon: NotedIcons.trash,
                  type: NotedIconButtonType.filled,
                  size: NotedWidgetSize.small,
                  color: NotedWidgetColor.tertiary,
                  onPressed: () => _confirmDeleteNotes(context, bloc),
                ),
                NotedIconButton(
                  icon: NotedIcons.close,
                  type: NotedIconButtonType.simple,
                  onPressed: () => bloc.add(HomeResetSelectionsEvent()),
                ),
              ]
            : [
                NotedIconButton(
                  icon: NotedIcons.settings,
                  type: NotedIconButtonType.filled,
                  size: NotedWidgetSize.small,
                  onPressed: () => context.push(SettingsRoute()),
                ),
              ];

        return NotedHeaderPage(
          title: isSelecting ? state.length.toString() : strings.notes_title,
          hasBackButton: false,
          headerBackgroundColor: isSelecting ? colors.secondary : colors.background,
          trailingActions: trailingActions,
          floatingActionButton: NotedIconButton(
            icon: NotedIcons.plus,
            type: NotedIconButtonType.filled,
            size: NotedWidgetSize.large,
            onPressed: () => context.push(const NotesAddRoute(plugin: NotedPlugin.notebook)),
            onLongPress: () => NotePicker.show(context),
          ),
          child: BlocProvider(
            create: (context) => NotesBloc(),
            child: const HomeFrame(),
          ),
        );
      },
    );
  }
}

Future<void> _confirmDeleteNotes(BuildContext context, HomeBloc bloc) async {
  Strings strings = context.strings();

  showDialog<bool>(
    context: context,
    builder: (context) => NotedDialog(
      leftActionText: strings.common_confirm,
      onLeftActionPressed: () {
        bloc.add(HomeDeleteSelectionsEvent());
        context.pop();
      },
      rightActionText: strings.common_cancel,
      onRightActionPressed: () => context.pop(),
      child: Text(strings.notes_delete_confirmText),
    ),
  );
}
