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
  final NotedError? error;

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
