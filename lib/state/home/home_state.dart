import 'package:equatable/equatable.dart';
import 'package:noted_app/util/errors/noted_exception.dart';

final class HomeState extends Equatable {
  final Set<String> selectedIds;
  final NotedError? error;

  const HomeState({required this.selectedIds, this.error});

  @override
  List<Object?> get props => [selectedIds];
}
