import 'package:bloc_test/bloc_test.dart';
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
      notes().setMsDelay(1);

      auth().reset();
      auth().setMsDelay(1);
      await auth().signInWithGoogle();
      await Future.delayed(const Duration(milliseconds: 5));
    });

    test('sorts notes by updated date', () {
      final state = NotesState.success(
        notes: {
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
          ).copyWith(id: 'third'),
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

      expect(state.sortedNoteIds, const ['first', 'second', 'third']);
    });

    blocTest(
      'loads and updates notes for a user',
      build: NotesBloc.new,
      act: (bloc) async {
        bloc.add(const NotesSubscribeEvent());
        await Future.delayed(const Duration(milliseconds: 15));
        notes().addNote(userId: auth().currentUser.id, note: testNote);
        await Future.delayed(const Duration(milliseconds: 10));
        notes().deleteNote(userId: auth().currentUser.id, noteId: 'test');
        await Future.delayed(const Duration(milliseconds: 5));
        bloc.add(NotesDeleteEvent(localNotes.values.map((note) => note.id).toList()));
        await Future.delayed(const Duration(milliseconds: 10));
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const NotesState.loading(),
        NotesState.success(notes: localNotes),
        NotesState.success(notes: {
          ...localNotes,
          ...{testNote.id: testNote},
        }),
        NotesState.success(notes: localNotes),
        const NotesState.empty(),
      ],
    );

    blocTest(
      'loads notes on auth change',
      build: NotesBloc.new,
      act: (bloc) async {
        await auth().signOut();
        await auth().signInWithGoogle();
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const NotesState.loading(),
        NotesState.success(notes: localNotes),
      ],
    );

    blocTest(
      'loads notes for a user and handles error',
      setUp: () => notes().setShouldThrow(true),
      build: NotesBloc.new,
      act: (bloc) => bloc.add(const NotesSubscribeEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const NotesState.loading(),
        NotesState.error(error: NotedError(ErrorCode.notes_subscribe_failed)),
      ],
    );

    blocTest(
      'loads notes for a user and handles initial stream error',
      build: NotesBloc.new,
      act: (bloc) async {
        notes().setStreamShouldThrow(true);
        bloc.add(const NotesSubscribeEvent());
        await Future.delayed(const Duration(milliseconds: 5));
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const NotesState.loading(),
        NotesState.error(error: NotedError(ErrorCode.notes_subscribe_failed)),
      ],
    );

    blocTest(
      'loads notes for a user and handles stream error',
      build: NotesBloc.new,
      act: (bloc) async {
        bloc.add(const NotesSubscribeEvent());
        await Future.delayed(const Duration(milliseconds: 5));
        notes().addStreamError();
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        const NotesState.loading(),
        NotesState.success(notes: localNotes),
        NotesState.success(notes: localNotes, error: NotedError(ErrorCode.notes_parse_failed)),
      ],
    );

    blocTest(
      'loads notes for a user fails with no auth',
      setUp: () async => auth().signOut(),
      build: NotesBloc.new,
      act: (bloc) => bloc.add(const NotesSubscribeEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotesState.error(error: NotedError(ErrorCode.notes_subscribe_failed, message: 'missing auth')),
      ],
    );

    blocTest(
      'delete notes for a user fails with no auth',
      setUp: () async => auth().signOut(),
      build: NotesBloc.new,
      act: (bloc) => bloc.add(const NotesDeleteEvent([])),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotesState.success(
          notes: const {},
          error: NotedError(ErrorCode.notes_delete_failed, message: 'missing auth'),
        ),
      ],
    );

    test('toggles selections for a user', () async {
      final notesBloc = NotesBloc();
      notesBloc.add(const NotesSubscribeEvent());
      await notesBloc.stream.firstWhere((state) => state.status == NotesStatus.loaded);

      expect(notesBloc.state.selectedIds.isEmpty, true);
      notesBloc.add(const NotesToggleSelectionEvent('test-note-0'));
      await notesBloc.stream.first;

      expect(notesBloc.state.selectedIds.isEmpty, false);
      notesBloc.add(const NotesToggleSelectionEvent('test-note-0'));
      await notesBloc.stream.first;

      expect(notesBloc.state.selectedIds.isEmpty, true);
      notesBloc.add(const NotesToggleSelectionEvent('test-note-0'));
      await notesBloc.stream.first;

      expect(notesBloc.state.selectedIds.isEmpty, false);
      notesBloc.add(const NotesResetSelectionsEvent());
      await notesBloc.stream.first;

      expect(notesBloc.state.selectedIds.isEmpty, true);
      notesBloc.add(const NotesToggleSelectionEvent('test-note-0'));
      await notesBloc.stream.first;

      expect(notesBloc.state.selectedIds.isEmpty, false);
      notesBloc.add(const NotesDeleteSelectionsEvent());
      await notesBloc.stream.first;

      expect(notesBloc.state.sortedNoteIds.length, 1);
      expect(notesBloc.state.selectedIds.isEmpty, true);
    });
  });
}
