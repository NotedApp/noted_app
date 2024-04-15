import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/edit/fields/edit_document_field.dart';
import 'package:noted_app/ui/pages/edit/fields/edit_text_field.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class NotebookEditContent extends StatefulWidget {
  const NotebookEditContent({super.key});

  @override
  State<StatefulWidget> createState() => _NotebookEditContentState();
}

class _NotebookEditContentState extends State<NotebookEditContent> {
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
              SliverToBoxAdapter(child: EditTextField.title(name: context.strings().edit_titlePlaceholder)),
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
