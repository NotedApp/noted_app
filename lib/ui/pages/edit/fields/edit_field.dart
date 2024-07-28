import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/state/edit/edit_state.dart';
import 'package:noted_app/ui/pages/edit/fields/edit_text_field.dart';
import 'package:noted_models/noted_models.dart';

class EditField extends StatelessWidget {
  final String fieldId;

  const EditField({required this.fieldId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<EditBloc, EditState, NoteField?>(
      selector: (state) => state.note?.fields[fieldId],
      builder: (context, field) => switch (field) {
        NoteTextField() => EditTextField(field: field),
        // TODO: Update this to be an error widget.
        _ => Container(),
      },
    );
  }
}
