import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/repository/notes/local_notebook_repository.dart';
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
  NotebookNoteModel testNote = NotebookNoteModel(id: 'test', title: 'test', document: testData0);
  NotebookNoteModel updatedTest = NotebookNoteModel(id: 'test', title: 'updated', document: testData0);

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

    blocTest(
      'loads, adds, updates, and deletes notes for a user',
      build: NotesBloc.new,
      act: (bloc) async {
        bloc.add(NotesSubscribeEvent());
        await Future.delayed(const Duration(milliseconds: 15));
        bloc.add(NotesAddEvent(testNote));
        await Future.delayed(const Duration(milliseconds: 5));
        bloc.add(NotesUpdateNoteEvent(updatedTest));
        await Future.delayed(const Duration(milliseconds: 5));
        bloc.add(NotesDeleteEvent(testNote.id));
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotesState(notes: [], status: NotesStatus.loading),
        NotesState(notes: localNotes.values.toList()),
        NotesState(notes: localNotes.values.toList(), status: NotesStatus.adding),
        NotesState(notes: localNotes.values.toList(), added: testNote.id),
        NotesState(notes: [...localNotes.values, testNote]),
        NotesState(notes: [...localNotes.values, updatedTest]),
        NotesState(notes: [...localNotes.values, updatedTest], status: NotesStatus.deleting),
        NotesState(notes: [...localNotes.values, updatedTest], deleted: testNote.id),
        NotesState(notes: localNotes.values.toList()),
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
        NotesState(
          notes: [],
        ),
        NotesState(notes: [], status: NotesStatus.loading),
        NotesState(notes: localNotes.values.toList()),
      ],
    );

    blocTest(
      'loads notes for a user and handles error',
      setUp: () => notes().setShouldThrow(true),
      build: NotesBloc.new,
      act: (bloc) => bloc.add(NotesSubscribeEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotesState(notes: [], status: NotesStatus.loading),
        NotesState(notes: [], error: NotedError(ErrorCode.notes_subscribe_failed)),
      ],
    );

    blocTest(
      'loads notes for a user and handles stream error',
      build: NotesBloc.new,
      act: (bloc) async {
        bloc.add(NotesSubscribeEvent());
        await Future.delayed(const Duration(milliseconds: 5));
        notes().addStreamError();
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotesState(notes: [], status: NotesStatus.loading),
        NotesState(notes: localNotes.values.toList()),
        NotesState(
          notes: localNotes.values.toList(),
          error: NotedError(ErrorCode.notes_parse_failed),
        ),
      ],
    );

    blocTest(
      'loads notes for a user fails with no auth',
      setUp: () async => auth().signOut(),
      build: NotesBloc.new,
      act: (bloc) => bloc.add(NotesSubscribeEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotesState(notes: [], error: NotedError(ErrorCode.notes_subscribe_failed, message: 'missing auth')),
      ],
    );

    blocTest(
      'adds a note and handles error',
      setUp: () => notes().setShouldThrow(true),
      build: NotesBloc.new,
      act: (bloc) => bloc.add(NotesAddEvent(testNote)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotesState(notes: [], status: NotesStatus.adding),
        NotesState(notes: [], error: NotedError(ErrorCode.notes_add_failed)),
      ],
    );

    blocTest(
      'adds a note fails with no auth',
      setUp: () async => auth().signOut(),
      build: NotesBloc.new,
      act: (bloc) => bloc.add(NotesAddEvent(testNote)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotesState(notes: [], error: NotedError(ErrorCode.notes_add_failed, message: 'missing auth')),
      ],
    );

    blocTest(
      'updates a note and handles error',
      setUp: () => notes().setShouldThrow(true),
      build: NotesBloc.new,
      act: (bloc) => bloc.add(NotesUpdateNoteEvent(testNote)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotesState(notes: [], error: NotedError(ErrorCode.notes_update_failed)),
      ],
    );

    blocTest(
      'updates a note fails with no auth',
      setUp: () async => auth().signOut(),
      build: NotesBloc.new,
      act: (bloc) => bloc.add(NotesUpdateNoteEvent(testNote)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotesState(notes: [], error: NotedError(ErrorCode.notes_update_failed, message: 'missing auth')),
      ],
    );

    blocTest(
      'deletes a note and handles error',
      setUp: () => notes().setShouldThrow(true),
      build: NotesBloc.new,
      act: (bloc) => bloc.add(NotesDeleteEvent('test-note-0')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotesState(notes: [], status: NotesStatus.deleting),
        NotesState(notes: [], error: NotedError(ErrorCode.notes_delete_failed)),
      ],
    );

    blocTest(
      'deletes a note fails with no auth',
      setUp: () async => auth().signOut(),
      build: NotesBloc.new,
      act: (bloc) => bloc.add(NotesDeleteEvent('test-note-0')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotesState(notes: [], error: NotedError(ErrorCode.notes_delete_failed, message: 'missing auth')),
      ],
    );
  });
}
