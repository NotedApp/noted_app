import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/notebook/local_notebook_repository.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

const NotebookNote testNote = NotebookNote(
  id: 'test-0',
  title: 'test note',
  document: [],
);

void main() {
  late LocalNotebookRepository repository;

  setUp(() {
    repository = LocalNotebookRepository();
    repository.setMsDelay(1);
  });

  group('LocalNotebookRepository', () {
    test('creates, updates, and deletes notes', () async {
      Stream<List<NotebookNote>> stream = await repository.subscribeNotes(userId: 'test');

      expectLater(
        stream,
        emitsInOrder([
          [...localNotes.values],
          [...localNotes.values, testNote],
          [...localNotes.values, testNote.copyWith(title: 'test updated note')],
          [...localNotes.values],
        ]),
      );

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
    });

    test('handles fetch error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.subscribeNotes(userId: 'test'),
        throwsA(NotedError(ErrorCode.notebook_subscribe_failed)),
      );
    });

    test('handles add error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.addNote(
          userId: 'test',
          note: NotebookNote(
            id: '',
            title: 'test note',
            document: [],
          ),
        ),
        throwsA(NotedError(ErrorCode.notebook_add_failed)),
      );
    });

    test('handles update error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.updateNote(
          userId: 'test',
          note: NotebookNote(
            id: 'test-note-0',
            title: 'test note',
            document: [],
          ),
        ),
        throwsA(NotedError(ErrorCode.notebook_update_failed)),
      );
    });

    test('handles delete error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.deleteNote(userId: 'test', noteId: 'test-note-0'),
        throwsA(NotedError(ErrorCode.notebook_delete_failed)),
      );
    });

    test('throws and resets when requested', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.addNote(userId: 'test', note: testNote),
        throwsA(NotedError(ErrorCode.notebook_add_failed)),
      );

      repository.reset();

      await repository.addNote(userId: 'test', note: testNote);
      repository.onDispose();
    });
  });
}
