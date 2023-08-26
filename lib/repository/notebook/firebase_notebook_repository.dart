import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noted_app/repository/notebook/notebook_repository.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/spaces/notebook/notebook_note.dart';

// TODO: Test this file.
// coverage:ignore-file
class FirebaseNotebookRepository extends NotebookRepository {
  final FirebaseFirestore _firestore;

  FirebaseNotebookRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<NotebookNote>> fetchNotes({required String userId}) async {
    try {
      QuerySnapshot<Object?> all = await notes(userId).get();
      return await all.docs.fold<List<NotebookNote>>([], (acc, obj) {
        Object? data = obj.data();

        if (data is Map<String, dynamic>) {
          acc.add(NotebookNote.fromMap(data));
        }

        return acc;
      });
    } on FirebaseException catch (e) {
      throw NotedException(ErrorCode.notebook_fetch_failed, message: e.code);
    } catch (_) {
      throw NotedException(ErrorCode.notebook_fetch_failed);
    }
  }

  @override
  Future<String> addNote({required String userId, required NotebookNote note}) async {
    try {
      return (await notes(userId).add(note.toMap())).id;
    } on FirebaseException catch (e) {
      throw NotedException(ErrorCode.notebook_add_failed, message: e.code);
    } catch (_) {
      throw NotedException(ErrorCode.notebook_add_failed);
    }
  }

  @override
  Future<void> updateNote({required String userId, required NotebookNote note}) async {
    try {
      await notes(userId).doc(note.id).set(note.toMap());
    } on FirebaseException catch (e) {
      throw NotedException(ErrorCode.notebook_update_failed, message: e.code);
    } catch (_) {
      throw NotedException(ErrorCode.notebook_update_failed);
    }
  }

  @override
  Future<void> deleteNoted({required String userId, required NotebookNote note}) async {
    try {
      await notes(userId).doc(note.id).delete();
    } on FirebaseException catch (e) {
      throw NotedException(ErrorCode.notebook_delete_failed, message: e.code);
    } catch (_) {
      throw NotedException(ErrorCode.notebook_delete_failed);
    }
  }

  CollectionReference notes(String userId) {
    return _firestore.collection('notes').doc(userId).collection('all');
  }
}
