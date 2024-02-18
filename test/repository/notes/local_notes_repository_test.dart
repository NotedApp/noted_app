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

      repository.addNote(userId: 'test', note: testNote);
      expect(await stream.first, [...localNotes.values, testNote]);

      repository.updateFields(
        userId: 'test',
        noteId: 'test-note-3',
        updates: [const NoteFieldValue(NoteField.title, 'updated note')],
      );
      final updated = await stream.first;
      expect(updated.length, 4);
      expect(updated.last.field(NoteField.title), 'updated note');

      repository.deleteNote(userId: 'test', noteId: 'test-note-3');
      expect(await stream.first, List.of(localNotes.values));

      repository.deleteNotes(userId: 'test', noteIds: List.of(localNotes.values.map((note) => note.id)));
      expect(await stream.first, []);
    });

    test('filters notes', () async {
      const filter = NotesFilter(plugins: {NotedPlugin.notebook});

      expect(await repository.fetchNotes(userId: 'test', filter: filter), [localNotes.values.firstOrNull]);

      var stream = await repository.subscribeNotes(userId: 'test', filter: filter);

      repository.addNote(userId: 'test', note: testNote);
      expect(await stream.first, [localNotes.values.first, testNote]);

      repository.updateFields(
        userId: 'test',
        noteId: 'test-note-3',
        updates: [const NoteFieldValue(NoteField.title, 'updated note')],
      );
      final updated = await stream.first;
      expect(updated.length, 2);
      expect(updated.last.field(NoteField.title), 'updated note');
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
        () => repository.updateFields(
          userId: 'test',
          noteId: 'test-note-3',
          updates: [const NoteFieldValue(NoteField.title, 'updated note')],
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
