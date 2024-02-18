import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:noted_app/repository/local_repository_config.dart';
import 'package:noted_app/repository/notes/mock_notes.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

/// Default local notes.
final localNotes = <String, NoteModel>{
  MockNotes.notebook0.id: MockNotes.notebook0,
  MockNotes.cookbook0.id: MockNotes.cookbook0,
  MockNotes.climbing0.id: MockNotes.climbing0,
};

/// A [NotesRepository] that uses mock data as its source of truth.
class LocalNotesRepository extends NotesRepository implements Disposable {
  final _notesController = StreamController<List<NoteModel>>.broadcast();
  final _controllers = localNotes.map((key, _) => MapEntry(key, StreamController<NoteModel>.broadcast()));
  final _notes = Map<String, NoteModel>.of(localNotes);

  var _shouldThrow = false;
  var _streamShouldThrow = false;
  var _msDelay = LocalRepositoryConfig.mockNetworkDelayMs;

  set shouldThrow(bool value) => _shouldThrow = value;
  set streamShouldThrow(bool value) => _streamShouldThrow = value;
  set msDelay(int value) => _msDelay = value;

  @override
  Future<List<NoteModel>> fetchNotes({required String userId, NotesFilter? filter}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedError(ErrorCode.notes_subscribe_failed);
    }

    return filterModels(filter, _notes.values.toList());
  }

  @override
  Future<NoteModel> fetchNote({required String userId, required String noteId}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    final note = _notes[noteId];

    if (_shouldThrow || userId.isEmpty || note == null) {
      throw NotedError(ErrorCode.notes_subscribe_failed);
    }

    return note;
  }

  @override
  Future<Stream<List<NoteModel>>> subscribeNotes({required String userId, NotesFilter? filter}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedError(ErrorCode.notes_subscribe_failed);
    }

    return _streamShouldThrow
        ? _notesController.stream.map((event) => throw NotedError(ErrorCode.notes_subscribe_failed))
        : _notesController.stream.map((event) => filterModels(filter, event));
  }

  @override
  Future<Stream<NoteModel>> subscribeNote({required String userId, required String noteId}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty || _controllers[noteId] == null) {
      throw NotedError(ErrorCode.notes_subscribe_failed);
    }

    return (_controllers[noteId]?.stream)!;
  }

  @override
  Future<String> addNote({required String userId, required NoteModel note}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedError(ErrorCode.notes_add_failed);
    }

    final id = note.id.isEmpty ? 'note-${_notes.length}' : note.id;
    final updated = note.copyWith(id: id);
    _notes[id] = updated;

    _controllers[id] = StreamController.broadcast(onListen: () => _controllers[id]?.add(updated));
    _notesController.add(_notes.values.toList());
    return id;
  }

  @override
  Future<void> updateFields({
    required String userId,
    required String noteId,
    required List<NoteFieldValue> updates,
  }) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    final note = _notes[noteId];

    if (_shouldThrow || userId.isEmpty || note == null) {
      throw NotedError(ErrorCode.notes_update_failed);
    }

    final updated = note.copyWithFields(updates);

    _notes[noteId] = updated;
    _controllers[note.id]?.add(updated);
    _notesController.add(_notes.values.toList());
  }

  @override
  Future<void> deleteNote({required String userId, required String noteId}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedError(ErrorCode.notes_delete_failed);
    }

    _notes.remove(noteId);
    _controllers[noteId]?.close();
    _controllers.remove(noteId);
    _notesController.add(_notes.values.toList());
  }

  @override
  Future<void> deleteNotes({required String userId, required List<String> noteIds}) async {
    await Future.delayed(Duration(milliseconds: _msDelay));

    if (_shouldThrow || userId.isEmpty) {
      throw NotedError(ErrorCode.notes_delete_failed);
    }

    _notes.removeWhere((key, value) => noteIds.contains(key));

    for (final noteId in noteIds) {
      _controllers[noteId]?.close();
      _controllers.remove(noteId);
    }

    _notesController.add(_notes.values.toList());
  }

  @override
  FutureOr onDispose() {
    for (final controller in _controllers.values) {
      controller.close();
    }

    _notesController.close();
  }

  /// Adds an error to the state stream for testing.
  void addStreamError() {
    _notesController.addError(NotedError(ErrorCode.notes_parse_failed));

    for (final controller in _controllers.values) {
      controller.addError(NotedError(ErrorCode.notes_parse_failed));
    }
  }

  void reset() {
    shouldThrow = false;
    streamShouldThrow = false;
    msDelay = LocalRepositoryConfig.mockNetworkDelayMs;

    _notes.clear();
    _notes.addAll(localNotes);

    _controllers.clear();
    _controllers.addAll(localNotes.map((key, value) => MapEntry(key, StreamController<NoteModel>.broadcast())));
  }
}
