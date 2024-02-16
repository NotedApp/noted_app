import 'package:noted_app/repository/ogp/ogp_repository.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/state/edit/edit_event.dart';
import 'package:noted_app/util/environment/environment.dart';
import 'package:noted_models/noted_models.dart';

class CookbookEditUpdateHandler extends EditUpdateHandler {
  final OgpRepository ogp;

  CookbookEditUpdateHandler({OgpRepository? ogpRepository}) : ogp = ogpRepository ?? locator<OgpRepository>();

  @override
  Future<void> run(NoteModel updated, EditBloc bloc) async {
    final link = updated.field(NoteField.link);

    if (link.isEmpty || updated.field(NoteField.imageUrl).isNotEmpty) {
      return;
    }

    final image = await ogp.fetchImage(link);

    if (image.isNotEmpty) {
      bloc.add(EditUpdateEvent(NoteFieldValue(NoteField.imageUrl, image)));
    }
  }
}
