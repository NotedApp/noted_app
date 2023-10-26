import 'package:equatable/equatable.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

enum NotesStatus {
  loaded,
  loading,
}

final class NotesState extends Equatable {
  final NotesStatus status;
  final List<NoteModel> notes;
  final NotedError? error;

  const NotesState({
    this.status = NotesStatus.loaded,
    required this.notes,
    this.error = null,
  });

  @override
  List<Object?> get props => [status, notes, error];
}
