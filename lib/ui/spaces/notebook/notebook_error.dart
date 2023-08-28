import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/notebook/notebook_bloc.dart';
import 'package:noted_app/state/notebook/notebook_event.dart';
import 'package:noted_app/ui/common/button/button.dart';
import 'package:noted_app/util/extensions.dart';

class NotebookError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Strings strings = context.strings();
    final NotebookBloc bloc = context.read();

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(strings.notebook_error_failed, textAlign: TextAlign.center),
            SizedBox(height: 12),
            NotedTextButton(
              label: strings.common_refresh,
              type: NotedTextButtonType.filled,
              onPressed: () => bloc.add(NotebookSubscribeNotesEvent()),
            ),
          ],
        ),
      ),
    );
  }
}
