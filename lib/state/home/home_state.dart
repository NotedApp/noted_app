import 'package:equatable/equatable.dart';

final class HomeState extends Equatable {
  final Set<String> selectedIds;
  int get numSelected => selectedIds.length;

  const HomeState({required this.selectedIds});

  @override
  List<Object?> get props => [selectedIds];
}
