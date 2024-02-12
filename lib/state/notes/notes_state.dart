import 'package:equatable/equatable.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

enum NotesStatus {
  loaded,
  loading,
  error,
  empty,
}

final class NotesState extends Equatable {
  final NotesStatus status;
  final Map<String, NoteModel> notes;
  final Set<String> selectedIds;
  final NotedError? error;

  List<String> get sortedNoteIds {
    List<String> noteIds = notes.keys.toList();
    noteIds.sort((id0, id1) {
      final note0 = notes[id0];
      final note1 = notes[id1];

      if (note0 != null && note1 != null) {
        return (note1.field(NoteField.lastUpdatedUtc)?.millisecondsSinceEpoch ?? 0) -
            (note0.field(NoteField.lastUpdatedUtc)?.millisecondsSinceEpoch ?? 0);
      } else {
        return note0?.field(NoteField.title).compareTo(note1?.field(NoteField.title) ?? '') ?? 0;
      }
    });

    return noteIds;
  }

  const NotesState.loading()
      : status = NotesStatus.loading,
        notes = const {},
        selectedIds = const {},
        error = null;

  const NotesState.success({
    required this.notes,
    this.selectedIds = const {},
    this.error,
  }) : status = NotesStatus.loaded;

  const NotesState.error({required this.error})
      : status = NotesStatus.error,
        notes = const {},
        selectedIds = const {};

  const NotesState.empty()
      : status = NotesStatus.empty,
        notes = const {},
        selectedIds = const {},
        error = null;

  @override
  List<Object?> get props => [status, notes, selectedIds, error];
}

final class NotesFilter extends Equatable {
  final Set<NotedPlugin> plugins;
  final Set<String> tagIds;

  const NotesFilter({required this.plugins, this.tagIds = const {}});

  // coverage:ignore-start
  @override
  List<Object?> get props => [plugins, tagIds];
  // coverage:ignore-end
}
