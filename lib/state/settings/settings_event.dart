import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_models/noted_models.dart';

sealed class SettingsEvent extends NotedEvent implements TrackableEvent {
  const SettingsEvent();
}

class SettingsLoadUserEvent extends SettingsEvent {
  final String userId;

  const SettingsLoadUserEvent(this.userId);
}

class SettingsUpdateStyleColorSchemeEvent extends SettingsEvent {
  final String userId;
  final NotedColorSchemeName schemeName;

  const SettingsUpdateStyleColorSchemeEvent(this.userId, this.schemeName);
}

class SettingsUpdateStyleCustomColorSchemeEvent extends SettingsEvent {
  final String userId;
  final NotedColorScheme colorScheme;

  const SettingsUpdateStyleCustomColorSchemeEvent(this.userId, this.colorScheme);
}

class SettingsUpdateStyleTextThemeEvent extends SettingsEvent {
  final String userId;
  final NotedTextTheme textTheme;

  const SettingsUpdateStyleTextThemeEvent(this.userId, this.textTheme);
}
