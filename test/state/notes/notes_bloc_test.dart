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
      'loads and updates notes for a user',
      build: NotesBloc.new,
      act: (bloc) async {
        bloc.add(NotesSubscribeEvent());
        await Future.delayed(const Duration(milliseconds: 15));
        notes().addNote(userId: auth().currentUser.id, note: testNote);
      },
      wait: const Duration(milliseconds: 10),
      expect: () => [
        NotesState(notes: [], status: NotesStatus.loading),
        NotesState(notes: localNotes.values.toList()),
        NotesState(notes: [...localNotes.values, testNote]),
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
  });
}