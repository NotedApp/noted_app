import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';
import 'package:uuid/uuid.dart';

/// Default local notes.
const Map<String, NotedNote> localNotes = {
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

/// A [NotesRepository] that uses mock data as its source of truth.
class LocalNotesRepository extends NotesRepository implements Disposable {
  late final StreamController<List<NotedNote>> _notesController;
  Map<String, NotedNote> _notes = {...localNotes};
  bool _shouldThrow = false;
  int _msDelay = 2000;

  LocalNotesRepository() {
    _notesController = StreamController.broadcast();
  }

  @override
  Future<Stream<List<NotedNote>>> subscribeNotes({required String userId}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedError(ErrorCode.notes_subscribe_failed);
    }

    return _notesController.stream;
  }

  @override
  Future<String> addNote({required String userId, required NotedNote note}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedError(ErrorCode.notes_add_failed);
    }

    String id = note.id.isEmpty ? Uuid().v4() : note.id;
    _notes[id] = note.copyWith(id: id);
    _notesController.add(_notes.values.toList());
    return id;
  }

  @override
  Future<void> updateNote({required String userId, required NotedNote note}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedError(ErrorCode.notes_update_failed);
    }

    _notes[note.id] = note.copyWith();
    _notesController.add(_notes.values.toList());
  }

  @override
  Future<void> deleteNote({required String userId, required String noteId}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedError(ErrorCode.notes_delete_failed);
    }

    _notes.remove(noteId);
    _notesController.add(_notes.values.toList());
  }

  @override
  FutureOr onDispose() {
    _notesController.close();
  }

  /// Adds an error to the state stream for testing.
  void addStreamError() {
    _notesController.addError(NotedError(ErrorCode.notes_parse_failed));
  }

  void setShouldThrow(bool shouldThrow) => _shouldThrow = shouldThrow;
  void setMsDelay(int msDelay) => _msDelay = msDelay;
  void reset() {
    _shouldThrow = false;
    _msDelay = 2000;
    _notes = {...localNotes};
  }
}
