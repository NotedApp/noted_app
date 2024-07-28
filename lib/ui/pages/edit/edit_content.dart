import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/state/edit/edit_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/edit/fields/edit_field.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class EditContent extends StatelessWidget {
  const EditContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditBloc, EditState, (bool, NoteEditLayout?)>(
      selector: (state) => (state.note?.defaultFields.document != null, state.note?.editLayout),
      builder: (context, pair) {
        final layout = pair.$2;

        if (layout == null) {
          return _ErrorContent();
        }

        return pair.$1
            ? _EditDocumentLayout(child: _EditLayout(layout: layout))
            : Expanded(child: _EditLayout(layout: layout));
      },
    );
  }
}

class _EditLayout extends StatelessWidget {
  final NoteEditLayout layout;

  const _EditLayout({required this.layout});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: layout.rows.map((row) => _EditRow(row: row)).toList(),
    );
  }
}

class _EditRow extends StatelessWidget {
  final NoteEditRow row;

  const _EditRow({required this.row});

  @override
  Widget build(BuildContext context) {
    return Row(children: row.fieldIds.map((fieldId) => Expanded(child: EditField(fieldId: fieldId))).toList());
  }
}

class _ErrorContent extends StatelessWidget {
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

class _EditDocumentLayout extends StatefulWidget {
  final Widget child;

  const _EditDocumentLayout({required this.child});

  @override
  State<StatefulWidget> createState() => _EditDocumentLayoutState();
}

class _EditDocumentLayoutState extends State<_EditDocumentLayout> {
  late final NotedEditorController documentController;

  @override
  void initState() {
    super.initState();

    final bloc = context.read<EditBloc>();
    documentController = NotedEditorController.quill(
      initial: bloc.state.note?.defaultFields.document ?? Document.empty,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NotedHeaderEditor(
            controller: documentController,
            placeholder: context.strings().edit_textPlaceholder,
            header: widget.child,
            autofocus: true,
            padding: const EdgeInsets.fromLTRB(
              Dimens.spacing_l,
              Dimens.spacing_l,
              Dimens.spacing_l,
              Dimens.size_64,
            ),
          ),
        ),
        NotedEditorToolbar(controller: documentController),
      ],
    );
  }

  @override
  void dispose() {
    documentController.dispose();
    super.dispose();
  }
}
