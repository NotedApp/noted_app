import 'package:noted_models/noted_models.dart';

/// A repository that handles the notebook module.
abstract class NotebookRepository {
  /// Fetches the notebook notes for the current user.
  Future<List<NotebookNote>> fetchNotes({required String userId});

  /// Adds a note for the given user, returning the ID of the note that was added.
  Future<String> addNote({required String userId, required NotebookNote note});

  /// Updates the given note for the given user.
  Future<void> updateNote({required String userId, required NotebookNote note});

  /// Deletes the note with the given ID for the given user.
  Future<void> deleteNote({required String userId, required String noteId});
}
