import 'package:equatable/equatable.dart';

class NotedError extends Error with EquatableMixin {
  final String messageKey;

  NotedError(this.messageKey);

  @override
  List<Object?> get props => [messageKey];
}
