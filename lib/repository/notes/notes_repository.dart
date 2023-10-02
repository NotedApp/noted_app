import 'package:noted_models/noted_models.dart';

/// A repository that handles the notebook module.
abstract class NotesRepository {
  /// Subscribes to the notebook notes for the given user.
  Future<Stream<List<NoteModel>>> subscribeNotes({required String userId});

  /// Adds a note for the given user, returning the ID of the note that was added.
  Future<String> addNote({required String userId, required NoteModel note});

  /// Updates the given note for the given user.
  Future<void> updateNote({required String userId, required NoteModel note});

  /// Deletes the note with the given ID for the given user.
  Future<void> deleteNote({required String userId, required String noteId});
}
