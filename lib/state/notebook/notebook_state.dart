import 'package:equatable/equatable.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

enum NotebookStatus {
  loaded,
  loading,
  adding,
  deleting,
}

final class NotebookState extends Equatable {
  final NotebookStatus status;
  final List<NotebookNote> notes;
  final String added;
  final String deleted;
  final NotedError? error;

  const NotebookState({
    this.status = NotebookStatus.loaded,
    required this.notes,
    this.added = '',
    this.deleted = '',
    this.error = null,
  });

  @override
  List<Object?> get props => [status, notes, added, deleted, error];
}
