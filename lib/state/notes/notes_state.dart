import 'package:equatable/equatable.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

enum NotesStatus {
  loaded,
  loading,
  adding,
  deleting,
}

final class NotesState extends Equatable {
  final NotesStatus status;
  final List<NoteModel> notes;
  final String added;
  final String deleted;
  final NotedError? error;

  const NotesState({
    this.status = NotesStatus.loaded,
    required this.notes,
    this.added = '',
    this.deleted = '',
    this.error = null,
  });

  @override
  List<Object?> get props => [status, notes, added, deleted, error];
}
