import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/notebook/local_notebook_repository.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

void main() {
  late LocalNotebookRepository repository;

  setUp(() {
    repository = LocalNotebookRepository();
    repository.setMsDelay(1);
  });

  group('LocalNotebookRepository', () {
    test('creates, updates, and deletes notes', () async {
      List<NotebookNote> notes = await repository.fetchNotes(userId: 'test');
      expect(notes.length, 2);
      expect(notes[0].id, 'test-note-0');

      await repository.addNote(
        userId: 'test',
        note: NotebookNote(
          id: '',
          title: 'test note',
          document: [],
        ),
      );

      notes = await repository.fetchNotes(userId: 'test');
      expect(notes.length, 3);
      expect(notes[2].title, 'test note');

      await repository.updateNote(
        userId: 'test',
        note: NotebookNote(
          id: 'test-note-0',
          title: 'test title',
          document: [],
        ),
      );

      notes = await repository.fetchNotes(userId: 'test');
      expect(notes.length, 3);
      expect(notes[0].title, 'test title');

      await repository.deleteNote(
        userId: 'test',
        noteId: 'test-note-0',
      );

      notes = await repository.fetchNotes(userId: 'test');
      expect(notes.length, 2);
      expect(notes[0].id, 'test-note-1');
    });

    test('handles fetch error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.fetchNotes(userId: 'test'),
        throwsA(NotedException(ErrorCode.notebook_fetch_failed)),
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
        throwsA(NotedException(ErrorCode.notebook_add_failed)),
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
        throwsA(NotedException(ErrorCode.notebook_update_failed)),
      );
    });

    test('handles delete error', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.deleteNote(userId: 'test', noteId: 'test-note-0'),
        throwsA(NotedException(ErrorCode.notebook_delete_failed)),
      );
    });

    test('throws and resets when requested', () async {
      repository.setShouldThrow(true);

      await expectLater(
        () => repository.fetchNotes(userId: 'test'),
        throwsA(NotedException(ErrorCode.notebook_fetch_failed)),
      );

      repository.reset();

      List<NotebookNote> notes = await repository.fetchNotes(userId: 'test');
      expect(notes.length, 2);
    });
  });
}
