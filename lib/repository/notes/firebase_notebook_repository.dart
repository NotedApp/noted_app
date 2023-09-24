import 'package:firebase_database/firebase_database.dart';
import 'package:noted_app/repository/notes/notes_repository.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

// TODO: Test this file.
// coverage:ignore-file
class FirebaseNotesRepository extends NotesRepository {
  final FirebaseDatabase _database;

  FirebaseNotesRepository({
    FirebaseDatabase? database,
  }) : _database = database ?? FirebaseDatabase.instance;

  DatabaseReference _notes(String userId) {
    return _database.ref('notes/$userId');
  }

  @override
  Future<Stream<List<NotedNote>>> subscribeNotes({required String userId}) async {
    try {
      return _notes(userId).onValue.map((event) {
        return event.snapshot.children.map((obj) {
          Object? val = obj.value;

          if (val == null || val is! Map) {
            throw NotedError(ErrorCode.notes_parse_failed);
          }

          return NotebookNote.fromMap(Map<String, dynamic>.from(val));
        }).toList();
      });
    } catch (_) {
      throw NotedError(ErrorCode.notes_subscribe_failed);
    }
  }

  @override
  Future<String> addNote({required String userId, required NotedNote note}) async {
    try {
      DatabaseReference ref = _notes(userId).push();

      if (ref.key?.isEmpty ?? true) {
        throw NotedError(ErrorCode.notes_add_failed, message: 'empty database key');
      }

      NotedNote toAdd = note.copyWith(id: ref.key);
      await ref.set(toAdd.toMap());
      return ref.key!;
    } catch (_) {
      throw NotedError(ErrorCode.notes_add_failed);
    }
  }

  @override
  Future<void> updateNote({required String userId, required NotedNote note}) async {
    try {
      await _notes(userId).child(note.id).set(note.toMap());
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
}
