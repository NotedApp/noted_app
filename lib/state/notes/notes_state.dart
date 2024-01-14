import 'package:equatable/equatable.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

enum NotesStatus {
  loaded,
  loading,
  error,
  empty,
}

const int maxInteger = 0x7FFFFFFFFFFFFFFF;

final class NotesState extends Equatable {
  final NotesStatus status;
  final Map<String, NoteModel> notes;
  final NotedError? error;

  List<String> get sortedNoteIds {
    List<String> noteIds = notes.keys.toList();
    noteIds.sort((id0, id1) {
      final note0 = notes[id0];
      final note1 = notes[id1];
      if (note0 != null && note1 != null) {
        return note1.lastUpdatedUtc.millisecondsSinceEpoch - note0.lastUpdatedUtc.millisecondsSinceEpoch;
      } else {
        return note0?.title.compareTo(note1?.title ?? '') ?? 0;
      }
    });
    return noteIds;
  }

  const NotesState.loading()
      : status = NotesStatus.loading,
        notes = const {},
        error = null;

  const NotesState.success({required this.notes, this.error}) : status = NotesStatus.loaded;

  const NotesState.error({required this.error})
      : status = NotesStatus.error,
        notes = const {};

  const NotesState.empty()
      : status = NotesStatus.empty,
        notes = const {},
        error = null;

  @override
  List<Object?> get props => [status, notes, error];
}
