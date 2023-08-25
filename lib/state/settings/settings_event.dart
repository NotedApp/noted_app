import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_models/noted_models.dart';

sealed class SettingsEvent extends NotedEvent implements TrackableEvent {
  const SettingsEvent();
}

class SettingsLoadUserEvent extends SettingsEvent {}

class SettingsUpdateStyleColorSchemeEvent extends SettingsEvent {
  final NotedColorSchemeName schemeName;

  const SettingsUpdateStyleColorSchemeEvent(this.schemeName);
}

class SettingsUpdateStyleCustomColorSchemeEvent extends SettingsEvent {
  final NotedColorScheme colorScheme;

  const SettingsUpdateStyleCustomColorSchemeEvent(this.colorScheme);
}

class SettingsUpdateStyleTextThemeEvent extends SettingsEvent {
  final NotedTextThemeName themeName;

  const SettingsUpdateStyleTextThemeEvent(this.themeName);
}
