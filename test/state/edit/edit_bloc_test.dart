import 'package:bloc_test/bloc_test.dart';
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
      await auth().signInWithGoogle();
      await Future.delayed(const Duration(milliseconds: 5));
    });

    blocTest(
      'adds and deletes a note',
      build: () => EditBloc.add(plugin: NotedPlugin.notebook),
      act: (bloc) async {
        await Future.delayed(const Duration(milliseconds: 20));
        bloc.add(EditDeleteEvent());
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const EditState(note: null, status: EditStatus.loading),
        EditState(note: addedNote, status: EditStatus.loaded),
        EditState(note: addedNote, status: EditStatus.deleting),
        const EditState(note: null, status: EditStatus.deleted),
      ],
    );

    blocTest(
      'loads and updates a note',
      build: () => EditBloc(noteId: 'test-note-0', updateDebounceMs: 0),
      act: (bloc) async {
        await Future.delayed(const Duration(milliseconds: 10));
        bloc.add(EditUpdateEvent(updated));
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const EditState(note: null, status: EditStatus.loading),
        EditState(note: existing, status: EditStatus.loaded),
        EditState(note: updated, status: EditStatus.loaded),
      ],
    );

    blocTest(
      'closes a note when auth is lost',
      build: () => EditBloc(noteId: 'test-note-0'),
      act: (bloc) async {
        await Future.delayed(const Duration(milliseconds: 10));
        auth().signOut();
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const EditState(note: null, status: EditStatus.loading),
        EditState(note: existing, status: EditStatus.loaded),
        const EditState(note: null, status: EditStatus.empty),
      ],
    );

    blocTest(
      'adds a note and handles error',
      setUp: () => notes().setShouldThrow(true),
      build: () => EditBloc.add(plugin: NotedPlugin.notebook),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const EditState(note: null, status: EditStatus.loading),
        EditState(note: null, status: EditStatus.empty, error: NotedError(ErrorCode.notes_add_failed)),
      ],
    );

    blocTest(
      'add a note fails with no auth',
      setUp: () async => auth().signOut(),
      build: () => EditBloc.add(plugin: NotedPlugin.notebook),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        EditState(
          note: null,
          status: EditStatus.empty,
          error: NotedError(ErrorCode.notes_add_failed, message: 'missing auth'),
        ),
      ],
    );

    blocTest(
      'add a note fails with wrong state',
      build: () => EditBloc.add(plugin: NotedPlugin.notebook),
      act: (bloc) async {
        bloc.add(EditAddEvent(addedNote));
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const EditState(note: null, status: EditStatus.loading),
        EditState(note: addedNote, status: EditStatus.loaded),
      ],
    );

    blocTest(
      'loads a note and handles error',
      setUp: () => notes().setShouldThrow(true),
      build: () => EditBloc(noteId: 'test-note-0'),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const EditState(note: null, status: EditStatus.loading),
        EditState(note: null, status: EditStatus.empty, error: NotedError(ErrorCode.notes_subscribe_failed)),
      ],
    );

    blocTest(
      'load a note fails with no auth',
      setUp: () async => auth().signOut(),
      build: () => EditBloc(noteId: 'test-note-0'),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        EditState(
          note: null,
          status: EditStatus.empty,
          error: NotedError(ErrorCode.notes_subscribe_failed, message: 'missing auth'),
        ),
      ],
    );

    blocTest(
      'load a note fails with wrong state',
      build: () => EditBloc(noteId: 'test-note-0'),
      act: (bloc) async {
        bloc.add(const EditLoadEvent('test-note-0'));
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const EditState(note: null, status: EditStatus.loading),
        EditState(note: existing, status: EditStatus.loaded),
      ],
    );

    blocTest(
      'loads notes and handles stream error',
      build: () => EditBloc(noteId: 'test-note-0'),
      act: (bloc) async {
        await Future.delayed(const Duration(milliseconds: 10));
        notes().addStreamError();
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const EditState(note: null, status: EditStatus.loading),
        EditState(note: existing, status: EditStatus.loaded),
        EditState(note: existing, status: EditStatus.loaded, error: NotedError(ErrorCode.notes_parse_failed)),
      ],
    );

    blocTest(
      'updates a note and handles error',
      build: () => EditBloc(noteId: 'test-note-0', updateDebounceMs: 0),
      act: (bloc) async {
        await Future.delayed(const Duration(milliseconds: 10));
        notes().setShouldThrow(true);
        bloc.add(EditUpdateEvent(updated));
        await Future.delayed(const Duration(milliseconds: 10));
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const EditState(note: null, status: EditStatus.loading),
        EditState(note: existing, status: EditStatus.loaded),
        EditState(note: existing, status: EditStatus.loaded, error: NotedError(ErrorCode.notes_update_failed)),
      ],
    );

    blocTest(
      'update a note fails with no auth',
      build: () => EditBloc(noteId: 'test-note-0'),
      act: (bloc) async {
        await Future.delayed(const Duration(milliseconds: 10));
        auth().signOut();
        await Future.delayed(const Duration(milliseconds: 10));
        bloc.add(EditUpdateEvent(updated));
        await Future.delayed(const Duration(milliseconds: 10));
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const EditState(note: null, status: EditStatus.loading),
        EditState(note: existing, status: EditStatus.loaded),
        const EditState(note: null, status: EditStatus.empty),
        EditState(
          note: null,
          status: EditStatus.loaded,
          error: NotedError(ErrorCode.notes_update_failed, message: 'missing auth'),
        ),
      ],
    );

    blocTest(
      'deletes a note and handles error',
      build: () => EditBloc(noteId: 'test-note-0'),
      act: (bloc) async {
        await Future.delayed(const Duration(milliseconds: 10));
        notes().setShouldThrow(true);
        bloc.add(EditDeleteEvent());
        await Future.delayed(const Duration(milliseconds: 10));
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const EditState(note: null, status: EditStatus.loading),
        EditState(note: existing, status: EditStatus.loaded),
        EditState(note: existing, status: EditStatus.deleting),
        EditState(note: existing, status: EditStatus.loaded, error: NotedError(ErrorCode.notes_delete_failed)),
      ],
    );

    blocTest(
      'delete a note fails with no auth',
      build: () => EditBloc(noteId: 'test-note-0'),
      act: (bloc) async {
        await Future.delayed(const Duration(milliseconds: 10));
        auth().signOut();
        await Future.delayed(const Duration(milliseconds: 10));
        bloc.add(EditDeleteEvent());
        await Future.delayed(const Duration(milliseconds: 10));
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const EditState(note: null, status: EditStatus.loading),
        EditState(note: existing, status: EditStatus.loaded),
        const EditState(note: null, status: EditStatus.empty),
      ],
    );

    blocTest(
      'delete a note fails with wrong state',
      build: () => EditBloc(noteId: 'test-note-0'),
      act: (bloc) async {
        bloc.add(EditDeleteEvent());
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const EditState(note: null, status: EditStatus.loading),
        EditState(note: existing, status: EditStatus.loaded),
      ],
    );
  });
}
