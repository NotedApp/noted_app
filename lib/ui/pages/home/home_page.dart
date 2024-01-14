import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_event.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/home/home_content.dart';
import 'package:noted_app/ui/pages/home/home_loading.dart';
import 'package:noted_app/ui/pages/home/note_picker.dart/note_picker.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Set<String> selectedNotes = {};
  bool get isSelecting => selectedNotes.isNotEmpty;

  void toggleSelection(String noteId) {
    if (selectedNotes.contains(noteId)) {
      selectedNotes.remove(noteId);
    } else {
      selectedNotes.add(noteId);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();
    ColorScheme colors = context.colorScheme();

    List<NotedIconButton> trailingActions = isSelecting
        ? [
            NotedIconButton(
              icon: NotedIcons.trash,
              type: NotedIconButtonType.filled,
              size: NotedWidgetSize.small,
              color: NotedWidgetColor.tertiary,
              onPressed: () => _confirmDeleteNotes(context, selectedNotes),
            ),
            NotedIconButton(
              icon: NotedIcons.close,
              type: NotedIconButtonType.simple,
              onPressed: () => setState(() => selectedNotes = {}),
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
      title: isSelecting ? selectedNotes.length.toString() : strings.notes_title,
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
      child: NotedBlocSelector<NotesBloc, NotesState, NotesStatus>(
        selector: (state) => state.status,
        listenWhen: (previous, current) =>
            (previous.notes.keys != current.notes.keys) || (previous.error?.code != current.error?.code),
        listener: (context, state) {
          final noteIds = state.notes.keys.toSet();
          setState(() => selectedNotes = selectedNotes.intersection(noteIds));

          if (state.error?.code == ErrorCode.notes_subscribe_failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              NotedSnackBar.createWithText(
                context: context,
                text: strings.edit_error_updateNoteFailed,
                hasClose: true,
              ),
            );
          }
        },
        builder: (context, bloc, state) => switch (state) {
          NotesStatus.loading => const HomeLoading(),
          NotesStatus.error => NotedErrorWidget(
              text: strings.notes_error_failed,
              ctaText: strings.common_refresh,
              ctaCallback: () => bloc.add(NotesSubscribeEvent()),
            ),
          NotesStatus.empty => NotedErrorWidget(text: strings.notes_error_empty),
          NotesStatus.loaded => HomeContent(selectedIds: selectedNotes, toggleSelection: toggleSelection),
        },
      ),
    );
  }
}

Future<void> _confirmDeleteNotes(BuildContext context, Set<String> ids) async {
  Strings strings = context.strings();
  NotesBloc bloc = context.read();

  showDialog<bool>(
    context: context,
    builder: (context) => NotedDialog(
      leftActionText: strings.common_confirm,
      onLeftActionPressed: () {
        bloc.add(NotesDeleteEvent(ids.toList()));
        context.pop();
      },
      rightActionText: strings.common_cancel,
      onRightActionPressed: () => context.pop(),
      child: Text(strings.notes_delete_confirmText),
    ),
  );
}
