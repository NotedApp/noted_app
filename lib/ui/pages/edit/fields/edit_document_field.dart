import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/state/edit/edit_event.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class EditDocumentField extends StatefulWidget {
  final NotedEditorController controller;

  const EditDocumentField({required this.controller, super.key});

  @override
  State<StatefulWidget> createState() => _EditDocumentFieldState();
}

class _EditDocumentFieldState extends State<EditDocumentField> {
  late final EditBloc bloc;
  late final StreamSubscription subscription;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    bloc = context.read();

    subscription = widget.controller.valueStream.listen(
      (value) => bloc.add(EditUpdateEvent(NoteFieldValue(NoteField.document, value))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotedEditor.quill(
      controller: widget.controller,
      focusNode: focusNode,
      placeholder: context.strings().edit_textPlaceholder,
      autofocus: true,
      usePrimaryScrollController: true,
      padding: const EdgeInsets.fromLTRB(
        Dimens.spacing_l,
        Dimens.spacing_l,
        Dimens.spacing_l,
        Dimens.size_64,
      ),
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    focusNode.dispose();

    super.dispose();
  }
}
