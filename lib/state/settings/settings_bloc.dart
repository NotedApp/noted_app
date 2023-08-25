import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/state/settings/settings_event.dart';
import 'package:noted_app/state/settings/settings_state.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

class SettingsBloc extends NotedBloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settings;
  final AuthRepository _auth;
  late final StreamSubscription<NotedUser> _userSubscription;

  SettingsBloc({SettingsRepository? settingsRepository, AuthRepository? authRepository})
      : _settings = settingsRepository ?? locator<SettingsRepository>(),
        _auth = authRepository ?? locator<AuthRepository>(),
        super(SettingsState(settings: NotedSettings()), 'settings') {
    on<SettingsLoadUserEvent>(_onLoadUser);
    on<SettingsUpdateStyleColorSchemeEvent>(_onUpdateStyleColorScheme);
    on<SettingsUpdateStyleCustomColorSchemeEvent>(_onUpdateStyleCustomColorScheme);
    on<SettingsUpdateStyleTextThemeEvent>(_onUpdateStyleTextTheme);

    _userSubscription = _auth.userStream.listen((user) {
      if (user.isNotEmpty) {
        add(SettingsLoadUserEvent());
      }
    });
  }

  void _onLoadUser(SettingsLoadUserEvent event, Emitter<SettingsState> emit) async {
    if (state.status == SettingsStatus.loading) {
      return;
    }

    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedException(ErrorCode.settings_fetch_failed, message: 'missing auth');
      }

      emit(SettingsState(status: SettingsStatus.loading, settings: state.settings));
      NotedSettings settings = await _settings.fetchSettings(userId: _auth.currentUser.id);
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
      state.settings.style.copyWith(colorSchemeName: event.schemeName),
      emit,
    );
  }

  void _onUpdateStyleCustomColorScheme(
    SettingsUpdateStyleCustomColorSchemeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _updateStyleSetting(
      state.settings.style.copyWith(customColorScheme: event.colorScheme),
      emit,
    );
  }

  void _onUpdateStyleTextTheme(
    SettingsUpdateStyleTextThemeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _updateStyleSetting(
      state.settings.style.copyWith(textThemeName: event.themeName),
      emit,
    );
  }

  Future<void> _updateStyleSetting(
    NotedStyleSettings style,
    Emitter<SettingsState> emit,
  ) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedException(ErrorCode.settings_updateStyle_failed, message: 'missing auth');
      }

      emit(SettingsState(settings: state.settings.copyWith(style: style)));
      await _settings.updateStyleSettings(userId: _auth.currentUser.id, style: style);
    } catch (e) {
      emit(SettingsState(error: NotedException.fromObject(e), settings: state.settings));
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
