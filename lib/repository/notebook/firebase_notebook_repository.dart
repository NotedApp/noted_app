import 'package:firebase_database/firebase_database.dart';
import 'package:noted_app/repository/notebook/notebook_repository.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/spaces/notebook/notebook_note.dart';

// TODO: Test this file.
// coverage:ignore-file
class FirebaseNotebookRepository extends NotebookRepository {
  final FirebaseDatabase _database;

  FirebaseNotebookRepository({
    FirebaseDatabase? database,
  }) : _database = database ?? FirebaseDatabase.instance;

  DatabaseReference _notes(String userId) {
    return _database.ref('notes/$userId');
  }

  @override
  Future<Stream<List<NotebookNote>>> subscribeNotes({required String userId}) async {
    try {
      return _notes(userId).onValue.map((event) {
        return event.snapshot.children.map((obj) {
          Object? val = obj.value;

          if (val == null || val is! Map<String, dynamic>) {
            throw NotedException(ErrorCode.notebook_subscribe_failed, message: 'parsing notes');
          }

          return NotebookNote.fromMap(val);
        }).toList();
      });
    } catch (_) {
      throw NotedException(ErrorCode.notebook_subscribe_failed);
    }
  }

  @override
  Future<String> addNote({required String userId, required NotebookNote note}) async {
    try {
      DatabaseReference ref = _notes(userId).push();

      if (ref.key?.isEmpty ?? true) {
        throw NotedException(ErrorCode.notebook_add_failed, message: 'empty database key');
      }

      NotebookNote toAdd = note.copyWith(id: ref.key);
      await ref.set(toAdd.toMap());
      return ref.key!;
    } catch (_) {
      throw NotedException(ErrorCode.notebook_add_failed);
    }
  }

  @override
  Future<void> updateNote({required String userId, required NotebookNote note}) async {
    try {
      await _notes(userId).child(note.id).set(note.toMap());
    } catch (_) {
      throw NotedException(ErrorCode.notebook_update_failed);
    }
  }

  @override
  Future<void> deleteNote({required String userId, required String noteId}) async {
    try {
      await _notes(userId).child(noteId).remove();
    } catch (_) {
      throw NotedException(ErrorCode.notebook_delete_failed);
    }
  }
}
