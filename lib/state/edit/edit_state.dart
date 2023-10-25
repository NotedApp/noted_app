import 'package:equatable/equatable.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

enum EditStatus {
  empty,
  loaded,
  loading,
  adding,
  updating,
  deleting,
}

final class EditState extends Equatable {
  final EditStatus status;
  final NoteModel? note;
  final NotedError? error;

  const EditState({
    this.status = EditStatus.loading,
    required this.note,
    this.error = null,
  });

  @override
  List<Object?> get props => [status, note, error];
}
