import 'package:equatable/equatable.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

enum SettingsStatus {
  loading,
  loaded,
}

final class SettingsState extends Equatable {
  final SettingsStatus status;
  final NotedSettings settings;
  final NotedException? error;

  const SettingsState({
    this.status = SettingsStatus.loaded,
    this.settings = const NotedSettings(),
    this.error = null,
  });

  @override
  List<Object?> get props => [status, settings, error];
}
