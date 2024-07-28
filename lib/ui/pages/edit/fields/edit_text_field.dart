import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/state/edit/edit_event.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_models/noted_models.dart';

extension on NoteTextFieldType {
  NotedTextFieldType get _fieldType => switch (this) {
        NoteTextFieldType.normal => NotedTextFieldType.plain,
        NoteTextFieldType.title => NotedTextFieldType.title,
      };

  EdgeInsetsGeometry get _padding => switch (this) {
        NoteTextFieldType.normal => const EdgeInsets.fromLTRB(Dimens.spacing_l, Dimens.spacing_xs, Dimens.spacing_l, 0),
        NoteTextFieldType.title => const EdgeInsets.fromLTRB(Dimens.spacing_l, Dimens.spacing_s, Dimens.spacing_l, 0),
      };
}

// coverage:ignore-file
class EditTextField extends StatefulWidget {
  final NoteTextField field;

  const EditTextField({required this.field, super.key});

  @override
  State<StatefulWidget> createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  late final EditBloc bloc;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    bloc = context.read();
    controller = TextEditingController(text: widget.field.value);
    controller.addListener(updateNote);
  }

  void updateNote() => bloc.add(EditUpdateEvent(widget.field.id, widget.field.copyWith(value: controller.text)));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.field.type._padding,
      child: NotedTextField(
        type: widget.field.type._fieldType,
        controller: controller,
        name: widget.field.type != NoteTextFieldType.title ? widget.field.name : null,
        hint: widget.field.type == NoteTextFieldType.title ? widget.field.name : null,
      ),
    );
  }

  @override
  void dispose() {
    controller.removeListener(updateNote);
    controller.dispose();

    super.dispose();
  }
}
