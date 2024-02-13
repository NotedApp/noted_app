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
    final models = notes.values.toList();
    models.sort((note0, note1) {
      final dateCompare = note1.msSinceEpoch - note0.msSinceEpoch;
      return dateCompare == 0 ? note0.field(NoteField.title).compareTo(note1.field(NoteField.title)) : dateCompare;
    });

    return models.map((model) => model.id).toList();
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

extension _NoteDate on NoteModel {
  int get msSinceEpoch => field(NoteField.lastUpdatedUtc)?.millisecondsSinceEpoch ?? 0;
}
