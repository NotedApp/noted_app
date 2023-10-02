import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/repository/auth/auth_repository.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/state/settings/settings_event.dart';
import 'package:noted_app/state/settings/settings_state.dart';
import 'package:noted_app/util/environment/dependencies.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

class SettingsBloc extends NotedBloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settings;
  final AuthRepository _auth;
  late final StreamSubscription<UserModel> _userSubscription;

  SettingsBloc({SettingsRepository? settingsRepository, AuthRepository? authRepository})
      : _settings = settingsRepository ?? locator<SettingsRepository>(),
        _auth = authRepository ?? locator<AuthRepository>(),
        super(const SettingsState(settings: SettingsModel()), 'settings') {
    on<SettingsLoadUserEvent>(_onLoadUser);
    on<SettingsUpdateStyleColorSchemeEvent>(_onUpdateStyleColorScheme);
    on<SettingsUpdateStyleCustomColorSchemeEvent>(_onUpdateStyleCustomColorScheme);
    on<SettingsUpdateStyleTextThemeEvent>(_onUpdateStyleTextTheme);
    on<SettingsResetEvent>(_onReset);

    _userSubscription = _auth.userStream.listen((user) {
      if (user.isEmpty) {
        add(SettingsResetEvent());
      } else {
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
        throw NotedError(ErrorCode.settings_fetch_failed, message: 'missing auth');
      }

      emit(SettingsState(status: SettingsStatus.loading, settings: state.settings));
      SettingsModel settings = await _settings.fetchSettings(userId: _auth.currentUser.id);
      emit(SettingsState(settings: settings));
    } catch (e) {
      emit(SettingsState(error: NotedError.fromObject(e), settings: state.settings));
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
    StyleSettingsModel style,
    Emitter<SettingsState> emit,
  ) async {
    try {
      if (_auth.currentUser.isEmpty) {
        throw NotedError(ErrorCode.settings_updateStyle_failed, message: 'missing auth');
      }

      emit(SettingsState(settings: state.settings.copyWith(style: style)));
      await _settings.updateStyleSettings(userId: _auth.currentUser.id, style: style);
    } catch (e) {
      emit(SettingsState(error: NotedError.fromObject(e), settings: state.settings));
    }
  }

  void _onReset(SettingsResetEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsState(settings: SettingsModel()));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
