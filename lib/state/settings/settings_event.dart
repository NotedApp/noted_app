import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_models/noted_models.dart';

sealed class SettingsEvent extends NotedEvent implements TrackableEvent {
  const SettingsEvent();
}

class SettingsLoadUserEvent extends SettingsEvent {}

class SettingsUpdateStyleColorSchemeEvent extends SettingsEvent {
  final ColorSchemeModelName schemeName;

  const SettingsUpdateStyleColorSchemeEvent(this.schemeName);
}

class SettingsUpdateStyleCustomColorSchemeEvent extends SettingsEvent {
  final ColorSchemeModel colorScheme;

  const SettingsUpdateStyleCustomColorSchemeEvent(this.colorScheme);
}

class SettingsUpdateStyleTextThemeEvent extends SettingsEvent {
  final TextThemeModelName themeName;

  const SettingsUpdateStyleTextThemeEvent(this.themeName);
}

class SettingsResetEvent extends SettingsEvent {}
