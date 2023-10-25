import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_event.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/edit/edit_content.dart';
import 'package:noted_app/ui/pages/edit/edit_loading.dart';
import 'package:noted_app/ui/pages/home/home_page.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

class EditPage extends StatefulWidget {
  final String? initialId;

  const EditPage({required this.initialId});

  @override
  State<StatefulWidget> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String? noteId;

  @override
  void initState() {
    noteId = widget.initialId ?? context.read<NotesBloc>().state.added;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesBloc, NotesState>(
      listenWhen: (previous, current) {
        return previous.status != current.status ||
            previous.error != current.error ||
            previous.getNote(noteId) != current.getNote(noteId);
      },
      listener: (context, state) {
        if (state.error != null) {
          handleNotesError(context, state);

          if (state.error?.code == ErrorCode.notes_add_failed) {
            context.pop();
          }
        } else if (state.deleted.isNotEmpty) {
          context.pop();
        } else if (state.added.isNotEmpty) {
          setState(() => noteId = state.added);
        }
      },
      builder: (context, state) {
        NoteModel? note = state.getNote(noteId);
        bool hasNote = note != null;

        return NotedHeaderPage(
          hasBackButton: true,
          trailingActions: [
            if (hasNote)
              NotedIconButton(
                icon: NotedIcons.trash,
                type: NotedIconButtonType.filled,
                size: NotedWidgetSize.small,
                onPressed: () => _confirmDeleteNote(context),
              ),
          ],
          child: hasNote ? EditContent(note: note) : EditLoading(),
        );
      },
    );
  }

  void _confirmDeleteNote(BuildContext context) async {
    Strings strings = context.strings();
    NotesBloc bloc = context.read();

    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => NotedDialog(
        child: Text(strings.notes_delete_confirmText),
        leftActionText: strings.common_confirm,
        onLeftActionPressed: () {
          bloc.add(NotesDeleteEvent(noteId ?? ''));
          context.pop(true);
        },
        rightActionText: strings.common_cancel,
        onRightActionPressed: () => context.pop(false),
      ),
    );

    if (result ?? false) {
      context.pop();
    }
  }
}
