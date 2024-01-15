import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/repository/notes/local_notes_repository.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/state/edit/edit_event.dart';
import 'package:noted_app/state/edit/edit_state.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

import '../../helpers/environment/unit_test_environment.dart';

void main() {
  group('EditBloc', () {
    LocalNotesRepository notes() => locator<NotesRepository>() as LocalNotesRepository;
    LocalAuthRepository auth() => locator<AuthRepository>() as LocalAuthRepository;

    NoteModel addedNote = NotebookNoteModel.empty().copyWith(id: 'note-2');

    NoteModel existing = localNotes.values.first.copyWith();
    NoteModel updated = existing.copyWith(title: 'updated');

    setUpAll(() => UnitTestEnvironment().configure());

    setUp(() async {
      notes().reset();
      notes().setMsDelay(1);

      auth().reset();
      auth().setMsDelay(1);
      auth().signInWithGoogle();
      await auth().userStream.firstWhere((user) => user.isNotEmpty);
    });

    test('adds and deletes a note', () async {
      final editBloc = EditBloc.add(plugin: NotedPlugin.notebook);
      final added = await editBloc.stream.firstWhere((state) => state.status == EditStatus.loaded);
      expect(added.note?.id, addedNote.id);

      editBloc.add(EditDeleteEvent());
      final deleted = await editBloc.stream.firstWhere((state) => state.status == EditStatus.deleted);
      expect(deleted.note, null);
    });

    test('loads and updates a note', () async {
      final editBloc = EditBloc(noteId: 'test-note-0', updateDebounceMs: 0);
      final original = await editBloc.stream.firstWhere((state) => state.status == EditStatus.loaded);
      expect(original.note?.title, existing.title);

      editBloc.add(EditUpdateEvent(updated));
      final update = await editBloc.stream.first;
      expect(update.note?.title, updated.title);
    });

    test('closes a note when auth is lost', () async {
      final editBloc = EditBloc(noteId: 'test-note-0');
      final original = await editBloc.stream.firstWhere((state) => state.status == EditStatus.loaded);
      expect(original.note?.title, existing.title);

      await auth().signOut();
      final update = await editBloc.stream.firstWhere((state) => state.status == EditStatus.empty);
      expect(update.note, null);
    });

    test('adds a note and handles error', () async {
      notes().setShouldThrow(true);

      final editBloc = EditBloc.add(plugin: NotedPlugin.notebook);
      final error = await editBloc.stream.firstWhere((state) => state.status == EditStatus.empty);
      expect(error.note, null);
    });

    test('add a note fails with no auth', () async {
      await auth().signOut();
      final editBloc = EditBloc.add(plugin: NotedPlugin.notebook);
      final empty = await editBloc.stream.firstWhere((state) => state.status == EditStatus.empty);
      expect(empty.note, null);
    });

    test('add a note fails with wrong state', () async {
      final editBloc = EditBloc.add(plugin: NotedPlugin.notebook);
      editBloc.add(EditAddEvent(addedNote));

      final loaded = await editBloc.stream.firstWhere((state) => state.status == EditStatus.loaded);
      expect(loaded.note?.title, addedNote.title);
    });

    test('loads a note and handles error', () async {
      notes().setShouldThrow(true);

      final editBloc = EditBloc(noteId: 'test-note-0');
      final error = await editBloc.stream.firstWhere((state) => state.status == EditStatus.empty);
      expect(error.note, null);
    });

    test('load a note fails with no auth', () async {
      await auth().signOut();
      final editBloc = EditBloc(noteId: 'test-note-0');
      final empty = await editBloc.stream.firstWhere((state) => state.status == EditStatus.empty);
      expect(empty.note, null);
    });

    test('load a note fails with wrong state', () async {
      final editBloc = EditBloc(noteId: 'test-note-0');
      editBloc.add(const EditLoadEvent('test-note-0'));

      final loaded = await editBloc.stream.firstWhere((state) => state.status == EditStatus.loaded);
      expect(loaded.note?.title, existing.title);
    });

    test('load a note and handles stream error', () async {
      final editBloc = EditBloc(noteId: 'test-note-0');
      final loaded = await editBloc.stream.firstWhere((state) => state.status == EditStatus.loaded);
      expect(loaded.note?.title, existing.title);

      notes().addStreamError();
      final error = await editBloc.stream.firstWhere((state) => state.error != null);
      expect(error.error?.code, ErrorCode.notes_parse_failed);
    });

    test('updates a note and handles error', () async {
      final editBloc = EditBloc(noteId: 'test-note-0');
      final original = await editBloc.stream.firstWhere((state) => state.status == EditStatus.loaded);
      expect(original.note?.title, existing.title);

      notes().setShouldThrow(true);
      editBloc.add(EditUpdateEvent(updated));
      final error = await editBloc.stream.first;
      expect(error.error?.code, ErrorCode.notes_update_failed);
    });

    test('update a note fails with no auth', () async {
      await auth().signOut();
      final editBloc = EditBloc(noteId: 'test-note-0');
      final empty = await editBloc.stream.firstWhere((state) => state.status == EditStatus.empty);
      expect(empty.note, null);

      editBloc.add(EditUpdateEvent(updated));
      final error = await editBloc.stream.first;
      expect(error.error?.code, ErrorCode.notes_update_failed);
    });

    test('deletes a note and handles error', () async {
      final editBloc = EditBloc(noteId: 'test-note-0');
      final original = await editBloc.stream.firstWhere((state) => state.status == EditStatus.loaded);
      expect(original.note?.title, existing.title);

      notes().setShouldThrow(true);
      editBloc.add(EditDeleteEvent());
      final deleting = await editBloc.stream.first;
      final error = await editBloc.stream.first;

      expect(deleting.status, EditStatus.deleting);
      expect(error.error?.code, ErrorCode.notes_delete_failed);
    });

    test('delete a note fails with wrong state', () async {
      final editBloc = EditBloc(noteId: 'test-note-0');
      editBloc.add(EditDeleteEvent());

      final loaded = await editBloc.stream.firstWhere((state) => state.status == EditStatus.loaded);
      expect(loaded.note?.title, existing.title);
    });
  });
}
