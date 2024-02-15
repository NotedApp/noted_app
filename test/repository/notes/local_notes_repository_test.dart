import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/notes/local_notes_repository.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

final testNote = NoteModel.value(
  NotedPlugin.notebook,
  overrides: [const NoteFieldValue(NoteField.title, 'test note')],
).copyWith(id: 'test-note-3');

final updatedNote = NoteModel.value(
  NotedPlugin.notebook,
  overrides: [const NoteFieldValue(NoteField.title, 'updated note')],
).copyWith(id: 'test-note-3');

void main() {
  late LocalNotesRepository repository;

  setUp(() {
    repository = LocalNotesRepository();
    repository.msDelay = 1;
  });

  group('LocalNotesRepository', () {
    test('creates, updates, and deletes notes', () async {
      expect(await repository.fetchNotes(userId: 'test'), List.of(localNotes.values));

      final stream = await repository.subscribeNotes(userId: 'test');

      expectLater(
        stream,
        emitsInOrder([
          [...localNotes.values, testNote],
          [...localNotes.values, updatedNote],
          [...localNotes.values],
          [],
        ]),
      );

      await repository.addNote(userId: 'test', note: testNote);
      await repository.updateNote(userId: 'test', note: updatedNote);
      await repository.deleteNote(userId: 'test', noteId: 'test-note-3');
      await repository.deleteNotes(userId: 'test', noteIds: List.of(localNotes.values.map((note) => note.id)));
    });

    test('filters notes', () async {
      const filter = NotesFilter(plugins: {NotedPlugin.notebook});

      expect(await repository.fetchNotes(userId: 'test', filter: filter), [localNotes.values.firstOrNull]);

      var stream = await repository.subscribeNotes(userId: 'test', filter: filter);

      expectLater(
        stream,
        emitsInOrder([
          [localNotes.values.firstOrNull, testNote],
          [localNotes.values.firstOrNull, updatedNote],
        ]),
      );

      await repository.addNote(userId: 'test', note: testNote);
      await repository.updateNote(userId: 'test', note: updatedNote);
    });

    test('handles fetch error', () async {
      repository.shouldThrow = true;

      await expectLater(
        () => repository.subscribeNotes(userId: 'test'),
        throwsA(NotedError(ErrorCode.notes_subscribe_failed)),
      );
    });

    test('handles fetch single error', () async {
      repository.shouldThrow = true;

      await expectLater(
        () => repository.subscribeNote(userId: 'test', noteId: 'test'),
        throwsA(NotedError(ErrorCode.notes_subscribe_failed)),
      );
    });

    test('handles add error', () async {
      repository.shouldThrow = true;

      await expectLater(
        () => repository.addNote(
          userId: 'test',
          note: testNote,
        ),
        throwsA(NotedError(ErrorCode.notes_add_failed)),
      );
    });

    test('handles update error', () async {
      repository.shouldThrow = true;

      await expectLater(
        () => repository.updateNote(
          userId: 'test',
          note: testNote,
        ),
        throwsA(NotedError(ErrorCode.notes_update_failed)),
      );
    });

    test('handles delete error', () async {
      repository.shouldThrow = true;

      await expectLater(
        () => repository.deleteNote(userId: 'test', noteId: 'test-notebook-0'),
        throwsA(NotedError(ErrorCode.notes_delete_failed)),
      );
    });

    test('handles delete multiple error', () async {
      repository.shouldThrow = true;

      await expectLater(
        () => repository.deleteNotes(userId: 'test', noteIds: ['test-notebook-0']),
        throwsA(NotedError(ErrorCode.notes_delete_failed)),
      );
    });

    test('throws and resets when requested', () async {
      repository.shouldThrow = true;

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
