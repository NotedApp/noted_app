import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/state/edit/edit_event.dart';
import 'package:noted_app/state/edit/edit_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/edit/fields/edit_document_field.dart';
import 'package:noted_app/ui/pages/edit/fields/edit_image_field.dart';
import 'package:noted_app/ui/pages/edit/fields/edit_text_field.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class ClimbingEditContent extends StatefulWidget {
  const ClimbingEditContent({super.key});

  @override
  State<StatefulWidget> createState() => _ClimbingEditContentState();
}

class _ClimbingEditContentState extends State<ClimbingEditContent> {
  late final NotedEditorController documentController;

  @override
  void initState() {
    super.initState();

    final bloc = context.read<EditBloc>();
    documentController = NotedEditorController.quill(
      initial: bloc.state.note?.field(NoteField.document) ?? NoteField.document.defaultValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const SliverToBoxAdapter(child: _ClimbingEditHeader()),
            ],
            body: EditDocumentField(controller: documentController),
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

class _ClimbingEditHeader extends StatelessWidget {
  const _ClimbingEditHeader();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditBloc, EditState, String>(
      selector: (state) => state.note?.field(NoteField.imageUrl) ?? '',
      builder: (context, imageUrl) {
        Strings strings = context.strings();

        return EditImageHeader(
          imageUrl: imageUrl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditTextField.title(name: strings.edit_titlePlaceholder),
              EditTextField(field: NoteField.imageUrl, name: strings.edit_imageUrl),
              EditTextField(field: NoteField.climbingRating, name: strings.climbing_rating),
              EditTextField(field: NoteField.location, name: strings.edit_location),
              // TODO: Add setting.
              // TODO: Add type.
              Row(
                children: [
                  const SizedBox(width: Dimens.spacing_l),
                  _ClimbingAttemptButton(
                    field: NoteField.climbingAttemptsUtc,
                    text: (context, count) => strings.climbing_attempts(count),
                    color: NotedWidgetColor.primary,
                  ),
                  const SizedBox(width: Dimens.spacing_m),
                  _ClimbingAttemptButton(
                    field: NoteField.climbingTopsUtc,
                    text: (context, count) => strings.climbing_tops(count),
                    color: NotedWidgetColor.tertiary,
                  ),
                  const SizedBox(width: Dimens.spacing_l),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class _ClimbingAttemptButton extends StatelessWidget {
  final NoteField<List<DateTime>> field;
  final String Function(BuildContext, int) text;
  final NotedWidgetColor color;

  const _ClimbingAttemptButton({
    required this.field,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotedBlocSelector<EditBloc, EditState, List<DateTime>>(
        selector: (state) => state.note?.field(field) ?? const [],
        builder: (context, bloc, attempts) {
          return NotedTextButton(
            label: text(context, attempts.length),
            type: NotedTextButtonType.filled,
            size: NotedWidgetSize.small,
            color: color,
            onPressed: () => bloc.add(
              EditUpdateEvent(NoteFieldValue(field, [...attempts, DateTime.now().toUtc()])),
            ),
            onLongPress: () => bloc.add(
              EditUpdateEvent(NoteFieldValue(field, attempts.sublist(0, max(attempts.length - 1, 0)))),
            ),
          );
        },
      ),
    );
  }
}
