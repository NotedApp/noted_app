import 'package:noted_app/repository/notebook/notebook_repository.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/spaces/notebook/notebook_note.dart';
import 'package:uuid/uuid.dart';

/// Default local notes.
const Map<String, NotebookNote> localNotes = {
  'test-note-0': NotebookNote(
    id: 'test-note-0',
    title: 'Note 0',
    document: [
      {'insert': 'hello world\n'},
    ],
  ),
  'test-note-1': NotebookNote(
    id: 'test-note-1',
    title: 'Note 1',
    document: [
      {'insert': 'hello world\n'},
    ],
  ),
};

/// A [NotebookRepository] that uses mock data as its source of truth.
class LocalNotebookRepository extends NotebookRepository {
  Map<String, NotebookNote> _notes = {...localNotes};
  bool _shouldThrow = false;
  int _msDelay = 2000;

  @override
  Future<List<NotebookNote>> fetchNotes({required String userId}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedException(ErrorCode.notebook_fetch_failed);
    }

    return _notes.values.toList();
  }

  @override
  Future<String> addNote({required String userId, required NotebookNote note}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedException(ErrorCode.notebook_add_failed);
    }

    String id = Uuid().v4();
    _notes[id] = note.copyWith(id: id);
    return id;
  }

  @override
  Future<void> updateNote({required String userId, required NotebookNote note}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedException(ErrorCode.notebook_update_failed);
    }

    _notes[note.id] = note.copyWith();
  }

  @override
  Future<void> deleteNote({required String userId, required String noteId}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedException(ErrorCode.notebook_delete_failed);
    }

    _notes.remove(noteId);
  }

  void setShouldThrow(bool shouldThrow) => _shouldThrow = shouldThrow;
  void setMsDelay(int msDelay) => _msDelay = msDelay;
  void reset() {
    _shouldThrow = false;
    _msDelay = 2000;
    _notes = {...localNotes};
  }
}
