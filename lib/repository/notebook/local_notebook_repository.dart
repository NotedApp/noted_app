import 'dart:async';

import 'package:get_it/get_it.dart';
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
class LocalNotebookRepository extends NotebookRepository implements Disposable {
  late final StreamController<List<NotebookNote>> _notesController;
  Map<String, NotebookNote> _notes = {...localNotes};
  bool _shouldThrow = false;
  int _msDelay = 2000;

  LocalNotebookRepository() {
    _notesController = StreamController.broadcast(onListen: () => _notesController.add(_notes.values.toList()));
  }

  @override
  Future<Stream<List<NotebookNote>>> subscribeNotes({required String userId}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedException(ErrorCode.notebook_subscribe_failed);
    }

    return _notesController.stream;
  }

  @override
  Future<String> addNote({required String userId, required NotebookNote note}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedException(ErrorCode.notebook_add_failed);
    }

    String id = note.id.isEmpty ? Uuid().v4() : note.id;
    _notes[id] = note.copyWith(id: id);
    _notesController.add(_notes.values.toList());
    return id;
  }

  @override
  Future<void> updateNote({required String userId, required NotebookNote note}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedException(ErrorCode.notebook_update_failed);
    }

    _notes[note.id] = note.copyWith();
    _notesController.add(_notes.values.toList());
  }

  @override
  Future<void> deleteNote({required String userId, required String noteId}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedException(ErrorCode.notebook_delete_failed);
    }

    _notes.remove(noteId);
    _notesController.add(_notes.values.toList());
  }

  @override
  FutureOr onDispose() {
    _notesController.close();
  }

  void setShouldThrow(bool shouldThrow) => _shouldThrow = shouldThrow;
  void setMsDelay(int msDelay) => _msDelay = msDelay;
  void reset() {
    _shouldThrow = false;
    _msDelay = 2000;
    _notes = {...localNotes};
  }
}
