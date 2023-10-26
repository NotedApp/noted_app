import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_event.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/home/home_content.dart';
import 'package:noted_app/ui/pages/home/home_loading.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/errors/noted_exception.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();
    NotesBloc bloc = context.watch();

    return BlocConsumer<NotesBloc, NotesState>(
      bloc: bloc,
      listenWhen: (previous, current) => previous.error != current.error,
      listener: (context, state) {
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
      builder: (context, state) => NotedHeaderPage(
        title: strings.notes_title,
        hasBackButton: false,
        trailingActions: [
          NotedIconButton(
            icon: NotedIcons.settings,
            type: NotedIconButtonType.filled,
            size: NotedWidgetSize.small,
            onPressed: () => context.push(SettingsRoute()),
          ),
        ],
        floatingActionButton: NotedIconButton(
          icon: NotedIcons.plus,
          type: NotedIconButtonType.filled,
          size: NotedWidgetSize.large,
          onPressed: () => context.push(NotesAddRoute()),
        ),
        child: switch (state) {
          NotesState(status: NotesStatus.loading) => HomeLoading(),
          NotesState(error: NotedError(code: ErrorCode.notes_subscribe_failed)) => NotedErrorWidget(
              text: strings.notes_error_failed,
              ctaText: strings.common_refresh,
              ctaCallback: () => bloc.add(NotesSubscribeEvent()),
            ),
          NotesState(notes: []) => NotedErrorWidget(text: strings.notes_error_empty),
          _ => HomeContent(notes: state.notes),
        },
      ),
    );
  }
}
