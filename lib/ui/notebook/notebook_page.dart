import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/notebook/notebook_bloc.dart';
import 'package:noted_app/state/notebook/notebook_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/notebook/notebook_content.dart';
import 'package:noted_app/ui/notebook/notebook_empty.dart';
import 'package:noted_app/ui/notebook/notebook_error.dart';
import 'package:noted_app/ui/notebook/notebook_loading.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/noted_exception.dart';

class NotebookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          listenWhen: (_, current) => current.error != null,
          buildWhen: (previous, current) => previous.notes != current.notes,
          listener: (context, state) => {},
          builder: (context, state) {
            if (state.status == NotebookStatus.loading) {
              return NotebookLoading();
            }

            if (state.error?.errorCode == ErrorCode.notebook_subscribe_failed) {
              return NotebookError();
            }

            if (state.notes.isEmpty) {
              return NotebookEmpty();
            }

            return NotebookContent(notes: state.notes);
          }),
    );
  }
}