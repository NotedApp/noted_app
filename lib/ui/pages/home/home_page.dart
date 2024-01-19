import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/home/home_bloc.dart';
import 'package:noted_app/state/home/home_event.dart';
import 'package:noted_app/state/home/home_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/home/all/all_content.dart';
import 'package:noted_app/ui/pages/home/cookbook/cookbook_content.dart';
import 'package:noted_app/ui/pages/home/note_picker/note_picker.dart';
import 'package:noted_app/ui/pages/home/notebook/notebook_content.dart';
import 'package:noted_app/ui/pages/home/plugin_bar.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

const _plugins = [NotedPlugin.notebook, NotedPlugin.cookbook];

// coverage:ignore-file
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final colors = context.colorScheme();

    final controller = PageController();

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
          child: Column(
            children: [
              PluginBar(controller: controller),
              _HomeContent(controller: controller, bloc: bloc),
            ],
          ),
        );
      },
    );
  }
}

class _HomeContent extends StatelessWidget {
  final PageController controller;
  final HomeBloc bloc;

  const _HomeContent({required this.controller, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        onPageChanged: (_) => bloc.add(HomeResetSelectionsEvent()),
        itemCount: _plugins.length + 1,
        itemBuilder: (context, index) {
          if (index <= 0) {
            return const AllContent();
          }

          return switch (_plugins.elementAtOrNull(index - 1)) {
            NotedPlugin.notebook => const NotebookContent(),
            NotedPlugin.cookbook => const CookbookContent(),
            _ => const AllContent(),
          };
        },
      ),
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
