import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/state/settings/settings_event.dart';
import 'package:noted_app/state/settings/settings_state.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

class SettingsBloc extends NotedBloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  SettingsBloc({SettingsRepository? settingsRepository})
      : _repository = settingsRepository ?? locator<SettingsRepository>(),
        super(SettingsState(settings: NotedSettings()), 'settings') {
    on<SettingsLoadUserEvent>(_onLoadUser);
    on<SettingsUpdateStyleColorSchemeEvent>(_onUpdateStyleColorScheme);
    on<SettingsUpdateStyleCustomColorSchemeEvent>(_onUpdateStyleCustomColorScheme);
    on<SettingsUpdateStyleTextThemeEvent>(_onUpdateStyleTextTheme);
  }

  void _onLoadUser(SettingsLoadUserEvent event, Emitter<SettingsState> emit) async {
    if (state.status == SettingsStatus.loading) {
      return;
    }

    try {
      emit(SettingsState(status: SettingsStatus.loading, settings: state.settings));
      NotedSettings settings = await _repository.fetchSettings(userId: event.userId);
      emit(SettingsState(settings: settings));
    } catch (e) {
      emit(SettingsState(error: NotedException.fromObject(e), settings: state.settings));
    }
  }

  void _onUpdateStyleColorScheme(
    SettingsUpdateStyleColorSchemeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _updateStyleSetting(
      event.userId,
      state.settings.style.copyWith(currentColorSchemeName: event.schemeName),
      emit,
    );
  }

  void _onUpdateStyleCustomColorScheme(
    SettingsUpdateStyleCustomColorSchemeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _updateStyleSetting(
      event.userId,
      state.settings.style.copyWith(customColorScheme: event.colorScheme),
      emit,
    );
  }

  void _onUpdateStyleTextTheme(
    SettingsUpdateStyleTextThemeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _updateStyleSetting(
      event.userId,
      state.settings.style.copyWith(textTheme: event.textTheme),
      emit,
    );
  }

  Future<void> _updateStyleSetting(
    String userId,
    NotedStyleSettings style,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(SettingsState(settings: state.settings.copyWith(style: style)));
      await _repository.updateStyleSettings(userId: userId, style: style);
    } catch (e) {
      emit(SettingsState(error: NotedException.fromObject(e), settings: state.settings));
    }
  }
}
