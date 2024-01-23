import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/notes/local_notes_repository.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

NotebookNoteModel testNote = NotebookNoteModel(
  id: 'test-0',
  title: 'test note',
  hidden: false,
  document: [],
);

void main() {
  late LocalNotesRepository repository;

  setUp(() {
    repository = LocalNotesRepository();
    repository.setMsDelay(1);
  });

  group('LocalNotesRepository', () {
    test('creates, updates, and deletes notes', () async {
      Stream<List<NoteModel>> stream = await repository.subscribeNotes(userId: 'test');

      Stream<NoteModel> singleStream = await repository.subscribeNote(userId: 'test', noteId: 'test-note-0');

      expectLater(
        stream,
        emitsInOrder([
          [...localNotes.values],
          [...localNotes.values, testNote],
          [...localNotes.values, testNote.copyWith(title: 'test updated note')],
          [...localNotes.values],
          [],
        ]),
      );

      expectLater(singleStream, emitsInOrder([localNotes.values.firstOrNull]));

      await repository.addNote(
        userId: 'test',
        note: testNote,
      );

      await repository.updateNote(
        userId: 'test',
        note: testNote.copyWith(title: 'test updated note'),
      );

      await repository.deleteNote(
        userId: 'test',
        noteId: 'test-0',
      );

      await repository.deleteNotes(
        userId: 'test',
        noteIds: localNotes.values.map((note) => note.id).toList(),
      );
    });

    test('filters notes', () async {
      var stream = await repository.subscribeNotes(
        userId: 'test',
        filter: const NotesFilter(plugins: {NotedPlugin.notebook}),
      );

      expectLater(
        stream,
        emitsInOrder([
          [localNotes.values.first]
        ]),
      );

      stream = await repository.subscribeNotes(
        userId: 'test',
        filter: const NotesFilter(plugins: {NotedPlugin.cookbook}),
      );

      expectLater(
        stream,
        emitsInOrder([
          [localNotes.values.elementAt(1)]
        ]),
      );
    });

    test('handles fetch error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.subscribeNotes(userId: 'test'),
        throwsA(NotedError(ErrorCode.notes_subscribe_failed)),
      );
    });

    test('handles fetch single error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.subscribeNote(userId: 'test', noteId: 'test'),
        throwsA(NotedError(ErrorCode.notes_subscribe_failed)),
      );
    });

    test('handles add error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.addNote(
          userId: 'test',
          note: NotebookNoteModel(
            id: '',
            title: 'test note',
            hidden: false,
            document: [],
          ),
        ),
        throwsA(NotedError(ErrorCode.notes_add_failed)),
      );
    });

    test('handles update error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.updateNote(
          userId: 'test',
          note: NotebookNoteModel(
            id: 'test-note-0',
            title: 'test note',
            hidden: false,
            document: [],
          ),
        ),
        throwsA(NotedError(ErrorCode.notes_update_failed)),
      );
    });

    test('handles delete error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.deleteNote(userId: 'test', noteId: 'test-note-0'),
        throwsA(NotedError(ErrorCode.notes_delete_failed)),
      );
    });

    test('handles delete multiple error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.deleteNotes(userId: 'test', noteIds: ['test-note-0']),
        throwsA(NotedError(ErrorCode.notes_delete_failed)),
      );
    });

    test('throws and resets when requested', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.addNote(userId: 'test', note: testNote),
        throwsA(NotedError(ErrorCode.notes_add_failed)),
      );

      repository.reset();

      await repository.addNote(userId: 'test', note: testNote);
      repository.onDispose();
    });
  });
}
