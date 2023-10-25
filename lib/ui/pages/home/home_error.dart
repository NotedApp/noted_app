import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_event.dart';
import 'package:noted_app/ui/common/button/button.dart';
import 'package:noted_app/util/extensions.dart';

class HomeError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Strings strings = context.strings();
    final NotesBloc bloc = context.watch();

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(strings.notes_error_failed, textAlign: TextAlign.center),
            SizedBox(height: 12),
            NotedTextButton(
              label: strings.common_refresh,
              type: NotedTextButtonType.filled,
              onPressed: () => bloc.add(NotesSubscribeEvent()),
            ),
          ],
        ),
      ),
    );
  }
}
