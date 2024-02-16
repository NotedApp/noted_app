import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/state/edit/edit_event.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_models/noted_models.dart';

enum TextFieldType {
  text,
  title,
}

extension on TextFieldType {
  NotedTextFieldType get _fieldType => switch (this) {
        TextFieldType.text => NotedTextFieldType.plain,
        TextFieldType.title => NotedTextFieldType.title,
      };

  EdgeInsetsGeometry get _padding => switch (this) {
        TextFieldType.text => const EdgeInsets.fromLTRB(Dimens.spacing_l, Dimens.spacing_xs, Dimens.spacing_l, 0),
        TextFieldType.title => const EdgeInsets.fromLTRB(Dimens.spacing_l, 0, Dimens.spacing_l, Dimens.spacing_xs),
      };
}

class EditTextField extends StatefulWidget {
  final NoteField<String> field;
  final TextFieldType type;
  final String name;

  const EditTextField({required this.field, required this.name, super.key}) : type = TextFieldType.text;

  const EditTextField.title({required this.name, super.key})
      : field = NoteField.title,
        type = TextFieldType.title;

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
    controller = TextEditingController(text: bloc.state.note?.field(widget.field) ?? widget.field.defaultValue);
    controller.addListener(updateNote);
  }

  void updateNote() => bloc.add(EditUpdateEvent(NoteFieldValue(widget.field, controller.text)));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.type._padding,
      child: NotedTextField(
        type: widget.type._fieldType,
        controller: controller,
        name: widget.type != TextFieldType.title ? widget.name : null,
        hint: widget.type == TextFieldType.title ? widget.name : null,
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
