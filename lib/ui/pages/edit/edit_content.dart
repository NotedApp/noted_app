import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/state/edit/edit_event.dart';
import 'package:noted_app/state/edit/edit_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/plugins/cookbook/cookbook_edit_content.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_edit_content.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class EditContent extends StatelessWidget {
  const EditContent({super.key});

  @override
  Widget build(BuildContext context) {
    return NotedBlocSelector<EditBloc, EditState, NoteModel?>(
      selector: (state) => state.note,
      builder: (context, bloc, note) {
        if (note == null) {
          return _EmptyContent();
        }

        void updateNote(NoteModel updated) => bloc.add(EditUpdateEvent(updated));

        return switch (note.plugin) {
          NotedPlugin.notebook => NotebookEditContent(note: note as NotebookNoteModel, updateNote: updateNote),
          NotedPlugin.cookbook => CookbookEditContent(note: note as CookbookNoteModel, updateNote: updateNote),
        };
      },
    );
  }
}

class _EmptyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();
    return NotedErrorWidget(
      text: strings.edit_error_empty,
      ctaText: strings.router_errorCta,
      ctaCallback: () => context.pop(),
    );
  }
}
