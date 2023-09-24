import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/auth/local_auth_repository.dart';
import 'package:noted_app/repository/notes/local_notebook_repository.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/state/notebook/notebook_bloc.dart';
import 'package:noted_app/state/notebook/notebook_event.dart';
import 'package:noted_app/state/notebook/notebook_state.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

import '../../helpers/environment/unit_test_environment.dart';
import '../../helpers/mocks/mock_delta.dart';

void main() {
  NotebookNote testNote = NotebookNote(id: 'test', title: 'test', document: testData0);
  NotebookNote updatedTest = NotebookNote(id: 'test', title: 'updated', document: testData0);

  group('NotebookBloc', () {
    LocalNotesRepository notebook() => locator<NotesRepository>() as LocalNotesRepository;
    LocalAuthRepository auth() => locator<AuthRepository>() as LocalAuthRepository;

    setUpAll(() => UnitTestEnvironment().configure());

    setUp(() async {
      notebook().reset();
      notebook().setMsDelay(1);

      auth().reset();
      auth().setMsDelay(1);
      await auth().signInWithGoogle();
      await Future.delayed(const Duration(milliseconds: 5));
    });

    blocTest(
      'loads, adds, updates, and deletes notes for a user',
      build: NotebookBloc.new,
      act: (bloc) async {
        bloc.add(NotebookSubscribeNotesEvent());
        await Future.delayed(const Duration(milliseconds: 15));
        bloc.add(NotebookAddNoteEvent(testNote));
        await Future.delayed(const Duration(milliseconds: 5));
        bloc.add(NotebookUpdateNoteEvent(updatedTest));
        await Future.delayed(const Duration(milliseconds: 5));
        bloc.add(NotebookDeleteNoteEvent(testNote.id));
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotebookState(notes: [], status: NotebookStatus.loading),
        NotebookState(notes: localNotes.values.toList()),
        NotebookState(notes: localNotes.values.toList(), status: NotebookStatus.adding),
        NotebookState(notes: localNotes.values.toList(), added: testNote.id),
        NotebookState(notes: [...localNotes.values, testNote]),
        NotebookState(notes: [...localNotes.values, updatedTest]),
        NotebookState(notes: [...localNotes.values, updatedTest], status: NotebookStatus.deleting),
        NotebookState(notes: [...localNotes.values, updatedTest], deleted: testNote.id),
        NotebookState(notes: localNotes.values.toList()),
      ],
    );

    blocTest(
      'loads notes on auth change',
      build: NotebookBloc.new,
      act: (bloc) async {
        await auth().signOut();
        await auth().signInWithGoogle();
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotebookState(
          notes: [],
        ),
        NotebookState(notes: [], status: NotebookStatus.loading),
        NotebookState(notes: localNotes.values.toList()),
      ],
    );

    blocTest(
      'loads notes for a user and handles error',
      setUp: () => notebook().setShouldThrow(true),
      build: NotebookBloc.new,
      act: (bloc) => bloc.add(NotebookSubscribeNotesEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotebookState(notes: [], status: NotebookStatus.loading),
        NotebookState(notes: [], error: NotedError(ErrorCode.notes_subscribe_failed)),
      ],
    );

    blocTest(
      'loads notes for a user and handles stream error',
      build: NotebookBloc.new,
      act: (bloc) async {
        bloc.add(NotebookSubscribeNotesEvent());
        await Future.delayed(const Duration(milliseconds: 5));
        notebook().addStreamError();
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotebookState(notes: [], status: NotebookStatus.loading),
        NotebookState(notes: localNotes.values.toList()),
        NotebookState(
          notes: localNotes.values.toList(),
          error: NotedError(ErrorCode.notes_parse_failed),
        ),
      ],
    );

    blocTest(
      'loads notes for a user fails with no auth',
      setUp: () async => auth().signOut(),
      build: NotebookBloc.new,
      act: (bloc) => bloc.add(NotebookSubscribeNotesEvent()),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotebookState(notes: [], error: NotedError(ErrorCode.notes_subscribe_failed, message: 'missing auth')),
      ],
    );

    blocTest(
      'adds a note and handles error',
      setUp: () => notebook().setShouldThrow(true),
      build: NotebookBloc.new,
      act: (bloc) => bloc.add(NotebookAddNoteEvent(testNote)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotebookState(notes: [], status: NotebookStatus.adding),
        NotebookState(notes: [], error: NotedError(ErrorCode.notes_add_failed)),
      ],
    );

    blocTest(
      'adds a note fails with no auth',
      setUp: () async => auth().signOut(),
      build: NotebookBloc.new,
      act: (bloc) => bloc.add(NotebookAddNoteEvent(testNote)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotebookState(notes: [], error: NotedError(ErrorCode.notes_add_failed, message: 'missing auth')),
      ],
    );

    blocTest(
      'updates a note and handles error',
      setUp: () => notebook().setShouldThrow(true),
      build: NotebookBloc.new,
      act: (bloc) => bloc.add(NotebookUpdateNoteEvent(testNote)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotebookState(notes: [], error: NotedError(ErrorCode.notes_update_failed)),
      ],
    );

    blocTest(
      'updates a note fails with no auth',
      setUp: () async => auth().signOut(),
      build: NotebookBloc.new,
      act: (bloc) => bloc.add(NotebookUpdateNoteEvent(testNote)),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotebookState(notes: [], error: NotedError(ErrorCode.notes_update_failed, message: 'missing auth')),
      ],
    );

    blocTest(
      'deletes a note and handles error',
      setUp: () => notebook().setShouldThrow(true),
      build: NotebookBloc.new,
      act: (bloc) => bloc.add(NotebookDeleteNoteEvent('test-note-0')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotebookState(notes: [], status: NotebookStatus.deleting),
        NotebookState(notes: [], error: NotedError(ErrorCode.notes_delete_failed)),
      ],
    );

    blocTest(
      'deletes a note fails with no auth',
      setUp: () async => auth().signOut(),
      build: NotebookBloc.new,
      act: (bloc) => bloc.add(NotebookDeleteNoteEvent('test-note-0')),
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotebookState(notes: [], error: NotedError(ErrorCode.notes_delete_failed, message: 'missing auth')),
      ],
    );
  });
}
