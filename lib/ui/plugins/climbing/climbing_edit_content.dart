import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
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

        final column = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditTextField.title(name: strings.edit_titlePlaceholder),
            EditTextField(field: NoteField.imageUrl, name: strings.edit_imageUrl),
            EditTextField(field: NoteField.climbingRating, name: strings.climbing_rating),
            EditTextField(field: NoteField.location, name: strings.edit_location),
            // TODO: Add setting.
            // TODO: Add type.
            // TODO: Add attempts.
            // TODO: Add tops.
          ],
        );

        if (imageUrl.isEmpty) {
          return column;
        }

        final width = MediaQuery.of(context).size.width / NotedWidgetConfig.goldenRatio;

        return Stack(
          children: [
            EditImageField(imageUrl: imageUrl),
            Padding(padding: EdgeInsets.only(top: width * 2 / 3), child: column),
          ],
        );
      },
    );
  }
}
