import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/repository/notes/local_notes_repository.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/repository/ogp/local_ogp_repository.dart';
import 'package:noted_app/repository/ogp/ogp_repository.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/state/edit/edit_event.dart';
import 'package:noted_app/state/edit/edit_state.dart';
import 'package:noted_app/util/environment/environment.dart';
import 'package:noted_models/noted_models.dart';

import '../../../../helpers/environment/unit_test_environment.dart';

void main() {
  group('Cookbook EditBloc', () {
    LocalNotesRepository notes() => locator<NotesRepository>() as LocalNotesRepository;
    LocalAuthRepository auth() => locator<AuthRepository>() as LocalAuthRepository;
    LocalOgpRepository ogp() => locator<OgpRepository>() as LocalOgpRepository;

    setUpAll(() => UnitTestEnvironment().configure());

    setUp(() async {
      notes().reset();
      notes().msDelay = 1;

      auth().reset();
      auth().msDelay = 1;
      auth().signInWithGoogle();
      await auth().userStream.firstWhere((user) => user.isNotEmpty);

      ogp().reset();
      ogp().imageUrl = 'test-image';
      ogp().msDelay = 1;
    });

    test('loads and updates a note image', () async {
      final editBloc = EditBloc.load(noteId: 'test-cookbook-0', updateDebounceMs: 1);

      final original = await editBloc.stream.firstWhere((state) => state.status == EditStatus.loaded);
      expect(original.note?.field(NoteField.link), '');
      expect(original.note?.field(NoteField.imageUrl), '');

      editBloc.add(const EditUpdateEvent(NoteFieldValue(NoteField.link, 'test-link')));
      final update0 = await editBloc.stream.first;
      expect(update0.note?.field(NoteField.link), 'test-link');
      expect(update0.note?.field(NoteField.imageUrl), '');

      final imageUrl = await editBloc.stream.first;
      expect(imageUrl.note?.field(NoteField.imageUrl), 'test-image');
    });
  });
}
