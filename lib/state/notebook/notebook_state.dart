import 'package:equatable/equatable.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

enum NotebookStatus {
  loading,
  loaded,
}

final class NotebookState extends Equatable {
  final NotebookStatus status;
  final List<NotebookNote> notes;
  final NotedException? error;

  const NotebookState({this.status = NotebookStatus.loaded, this.notes = const [], this.error = null});

  @override
  List<Object?> get props => [status, notes, error];
}
