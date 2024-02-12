import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_models/noted_models.dart';

/// A repository that handles the notebook module.
abstract class NotesRepository {
  /// Subscribes to the notebook notes for the given user, with the given filter.
  Future<Stream<List<NoteModel>>> subscribeNotes({required String userId, NotesFilter? filter});

  /// Subscribes to a specific note for the given user.
  Future<Stream<NoteModel>> subscribeNote({required String userId, required String noteId});

  /// Adds a note for the given user, returning the ID of the note that was added.
  Future<String> addNote({required String userId, required NoteModel note});

  /// Updates the given note for the given user.
  Future<void> updateNote({required String userId, required NoteModel note});

  /// Deletes the note with the given ID for the given user.
  Future<void> deleteNote({required String userId, required String noteId});

  /// Deletes all notes with the given IDs for the given user.
  Future<void> deleteNotes({required String userId, required List<String> noteIds});
}

List<NoteModel> filterModels(NotesFilter? filter, List<NoteModel> models) {
  if (filter == null) {
    return models;
  }

  return models.where((model) {
    if (filter.plugins.isNotEmpty && !filter.plugins.contains(model.plugin)) {
      return false;
    }

    if (filter.tagIds.isNotEmpty && !filter.tagIds.containsAll(model.field(NoteField.tagIds))) {
      return false;
    }

    return true;
  }).toList();
}
