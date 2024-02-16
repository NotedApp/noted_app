import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/repository/notes/local_notes_repository.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_event.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

import '../../helpers/environment/unit_test_environment.dart';
import '../../helpers/mocks/mock_delta.dart';

void main() {
  final testNote = NoteModel.value(
    NotedPlugin.notebook,
    overrides: [
      const NoteFieldValue(NoteField.title, 'test'),
      const NoteFieldValue(NoteField.document, testData0),
    ],
  ).copyWith(id: 'test');

  group('NotesBloc', () {
    LocalNotesRepository notes() => locator<NotesRepository>() as LocalNotesRepository;
    LocalAuthRepository auth() => locator<AuthRepository>() as LocalAuthRepository;

    setUpAll(() => UnitTestEnvironment().configure());

    setUp(() async {
      notes().reset();
      notes().msDelay = 1;

      auth().reset();
      auth().msDelay = 1;
      await auth().signInWithGoogle();
      await Future.delayed(const Duration(milliseconds: 5));
    });

    test('sorts notes by updated date', () {
      final state = NotesState.success(
        notes: {
          'zzz-last-1': NoteModel.value(
            NotedPlugin.notebook,
            overrides: [
              const NoteFieldValue(NoteField.title, 'zzz-last-1'),
              const NoteFieldValue(NoteField.document, testData0),
            ],
          ).copyWith(id: 'zzz-last-1'),
          'zzz-last-0': NoteModel.value(
            NotedPlugin.notebook,
            overrides: [
              const NoteFieldValue(NoteField.title, 'zzz-last-0'),
              const NoteFieldValue(NoteField.document, testData0),
            ],
          ).copyWith(id: 'zzz-last-0'),
          'third': NoteModel.value(
            NotedPlugin.notebook,
            overrides: [
              const NoteFieldValue(NoteField.title, 'third'),
              const NoteFieldValue(NoteField.document, testData0),
              NoteFieldValue(NoteField.lastUpdatedUtc, DateTime.fromMillisecondsSinceEpoch(500)),
            ],
          ).copyWith(id: 'third'),
          'first': NoteModel.value(
            NotedPlugin.notebook,
            overrides: [
              const NoteFieldValue(NoteField.title, 'first'),
              const NoteFieldValue(NoteField.document, testData0),
              NoteFieldValue(NoteField.lastUpdatedUtc, DateTime.fromMillisecondsSinceEpoch(1000)),
            ],
          ).copyWith(id: 'first'),
          'second': NoteModel.value(
            NotedPlugin.notebook,
            overrides: [
              const NoteFieldValue(NoteField.title, 'second'),
              const NoteFieldValue(NoteField.document, testData0),
              NoteFieldValue(NoteField.lastUpdatedUtc, DateTime.fromMillisecondsSinceEpoch(750)),
            ],
          ).copyWith(id: 'second'),
        },
      );

      expect(state.sortedNoteIds, const ['first', 'second', 'third', 'zzz-last-0', 'zzz-last-1']);
    });

    test('loads empty notes for a user', () async {
      await notes().deleteNotes(userId: 'test', noteIds: localNotes.values.map((note) => note.id).toList());

      final bloc = NotesBloc();
      final loaded = await bloc.stream.firstWhere((state) => state.status == NotesStatus.empty);
      expect(loaded.notes.length, 0);
    });

    test('loads and updates notes for a user', () async {
      final bloc = NotesBloc();
      final loaded = await bloc.stream.firstWhere((state) => state.status == NotesStatus.loaded);
      expect(loaded.notes.length, 3);

      notes().addNote(userId: auth().currentUser.id, note: testNote);
      final added = await bloc.stream.first;
      expect(added.notes.length, 4);

      notes().deleteNote(userId: auth().currentUser.id, noteId: testNote.id);
      final deleted = await bloc.stream.first;
      expect(deleted.notes.length, 3);

      bloc.add(NotesDeleteEvent(localNotes.values.map((note) => note.id).toList()));
      final empty = await bloc.stream.first;
      expect(empty, const NotesState.empty());

      await bloc.close();
    });

    test('loads notes on auth change', () async {
      final bloc = NotesBloc();
      final loaded = await bloc.stream.firstWhere((state) => state.status == NotesStatus.loaded);
      expect(loaded.notes.length, 3);

      await auth().signOut();
      final signedOut = await bloc.stream.firstWhere((state) => state.status == NotesStatus.loading);
      expect(signedOut.notes.length, 0);

      await auth().signInWithGoogle();
      final signedIn = await bloc.stream.firstWhere((state) => state.status == NotesStatus.loaded);
      expect(signedIn.notes.length, 3);
    });

    test('load notes for a user and handles error', () async {
      notes().shouldThrow = true;
      final bloc = NotesBloc();
      bloc.add(const NotesSubscribeEvent());
      final error = await bloc.stream.firstWhere((state) => state.error != null);
      expect(error.error?.code, ErrorCode.notes_subscribe_failed);
    });

    test('loads notes for a user and handles stream error', () async {
      notes().streamShouldThrow = true;
      final bloc = NotesBloc();
      final loaded = await bloc.stream.firstWhere((state) => state.status == NotesStatus.loaded);
      expect(loaded.notes.length, 3);

      notes().addNote(userId: 'test', note: testNote);
      final error = await bloc.stream.firstWhere((state) => state.error != null);
      expect(error.error?.code, ErrorCode.notes_subscribe_failed);
    });

    test('load notes for a user fails with no auth', () async {
      await auth().signOut();
      final bloc = NotesBloc();
      bloc.add(const NotesSubscribeEvent());
      final error = await bloc.stream.firstWhere((state) => state.error != null);
      expect(error.error?.code, ErrorCode.notes_subscribe_failed);
    });

    test('delete notes for a user fails with no auth', () async {
      await auth().signOut();
      final bloc = NotesBloc();
      bloc.add(const NotesDeleteEvent([]));
      final error = await bloc.stream.firstWhere((state) => state.error != null);
      expect(error.error?.code, ErrorCode.notes_delete_failed);
    });

    test('toggles selections for a user', () async {
      final notesBloc = NotesBloc();
      notesBloc.add(const NotesSubscribeEvent());
      await notesBloc.stream.firstWhere((state) => state.status == NotesStatus.loaded);

      expect(notesBloc.state.selectedIds.isEmpty, true);
      notesBloc.add(const NotesToggleSelectionEvent('test-notebook-0'));
      await notesBloc.stream.first;

      expect(notesBloc.state.selectedIds.isEmpty, false);
      notesBloc.add(const NotesToggleSelectionEvent('test-notebook-0'));
      await notesBloc.stream.first;

      expect(notesBloc.state.selectedIds.isEmpty, true);
      notesBloc.add(const NotesToggleSelectionEvent('test-notebook-0'));
      await notesBloc.stream.first;

      expect(notesBloc.state.selectedIds.isEmpty, false);
      notesBloc.add(const NotesResetSelectionsEvent());
      await notesBloc.stream.first;

      expect(notesBloc.state.selectedIds.isEmpty, true);
      notesBloc.add(const NotesToggleSelectionEvent('test-notebook-0'));
      await notesBloc.stream.first;

      expect(notesBloc.state.selectedIds.isEmpty, false);
      notesBloc.add(const NotesDeleteSelectionsEvent());
      await notesBloc.stream.first;

      expect(notesBloc.state.sortedNoteIds.length, 2);
      expect(notesBloc.state.selectedIds.isEmpty, true);
    });
  });
}
