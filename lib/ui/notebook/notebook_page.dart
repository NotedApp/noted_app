import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/notebook/notebook_bloc.dart';
import 'package:noted_app/state/notebook/notebook_event.dart';
import 'package:noted_app/state/notebook/notebook_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/util/extensions.dart';

class NotebookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotebookBloc bloc = context.read();
    Strings strings = context.strings();

    return NotedHeaderPage(
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
      child: BlocConsumer<NotebookBloc, NotebookState>(
        listener: (context, state) => {},
        builder: (context, state) => RefreshIndicator(
          strokeWidth: 2,
          color: context.theme().colorScheme.tertiary,
          backgroundColor: Colors.transparent,
          onRefresh: () {
            bloc.add(NotebookLoadNotesEvent());
            return bloc.stream.firstWhere((state) => state.status != NotebookStatus.loading);
          },
          child: GridView.builder(
            physics: notedScrollPhysics,
            gridDelegate: gridDelegate,
            itemBuilder: itemBuilder,
          ),
        ),
      ),
    );
  }
}
