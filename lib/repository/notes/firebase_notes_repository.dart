import 'package:firebase_database/firebase_database.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

// TODO: Test this file.
// coverage:ignore-file
class FirebaseNotesRepository extends NotesRepository {
  final FirebaseDatabase _database;

  FirebaseNotesRepository({
    FirebaseDatabase? database,
  }) : _database = database ?? FirebaseDatabase.instance;

  DatabaseReference _notes(String userId) => _database.ref('notes/$userId');

  @override
  Future<List<NoteModel>> fetchNotes({required String userId, NotesFilter? filter}) async {
    try {
      final notes = await _notes(userId).get();
      return filterModels(filter, notes.children.map(_parseNote).toList());
    } catch (_) {
      throw NotedError(ErrorCode.notes_subscribe_failed);
    }
  }

  @override
  Future<NoteModel> fetchNote({required String userId, required String noteId}) async {
    try {
      return _parseNote(await _notes(userId).child(noteId).get());
    } catch (_) {
      throw NotedError(ErrorCode.notes_subscribe_failed);
    }
  }

  @override
  Future<Stream<List<NoteModel>>> subscribeNotes({required String userId, NotesFilter? filter}) async {
    try {
      return _notes(userId).onValue.map((event) {
        return filterModels(filter, event.snapshot.children.map(_parseNote).toList());
      });
    } catch (_) {
      throw NotedError(ErrorCode.notes_subscribe_failed);
    }
  }

  @override
  Future<Stream<NoteModel>> subscribeNote({required String userId, required String noteId}) async {
    try {
      return _notes(userId).child(noteId).onValue.map((event) => _parseNote(event.snapshot));
    } catch (_) {
      throw NotedError(ErrorCode.notes_subscribe_failed);
    }
  }

  @override
  Future<String> addNote({required String userId, required NoteModel note}) async {
    try {
      DatabaseReference ref = _notes(userId).push();

      if (ref.key?.isEmpty ?? true) {
        throw NotedError(ErrorCode.notes_add_failed, message: 'empty database key');
      }

      NoteModel toAdd = note.copyWith(id: ref.key);
      await ref.set(toAdd.toMap());
      return ref.key!;
    } catch (_) {
      throw NotedError(ErrorCode.notes_add_failed);
    }
  }

  @override
  Future<void> updateFields({
    required String userId,
    required String noteId,
    required List<NoteFieldValue> updates,
  }) async {
    try {
      final fieldUpdates = {for (var update in updates) update.field.name: update.value};
      await _notes(userId).child(noteId).child('fields').update(fieldUpdates);
    } catch (_) {
      throw NotedError(ErrorCode.notes_update_failed);
    }
  }

  @override
  Future<void> deleteNote({required String userId, required String noteId}) async {
    try {
      await _notes(userId).child(noteId).remove();
    } catch (_) {
      throw NotedError(ErrorCode.notes_delete_failed);
    }
  }

  @override
  Future<void> deleteNotes({required String userId, required List<String> noteIds}) async {
    try {
      await Future.wait(noteIds.map((id) => _notes(userId).child(id).remove()));
    } catch (_) {
      throw NotedError(ErrorCode.notes_delete_failed);
    }
  }
}

NoteModel _parseNote(DataSnapshot snapshot) {
  final value = snapshot.value;

  if (value == null || value is! Map) {
    throw NotedError(ErrorCode.notes_parse_failed);
  }

  return NoteModel.fromMap(Map<String, dynamic>.from(value));
}
