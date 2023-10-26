import 'package:equatable/equatable.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

enum SettingsStatus {
  loading,
  loaded,
}

final class SettingsState extends Equatable {
  final SettingsStatus status;
  final SettingsModel settings;
  final NotedError? error;

  const SettingsState({
    this.status = SettingsStatus.loaded,
    required this.settings,
    this.error = null,
  });

  @override
  List<Object?> get props => [status, settings, error];
}
