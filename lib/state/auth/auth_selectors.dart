import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/auth/auth_state.dart';

abstract class AuthSelectors {
  static BlocWidgetSelector<AuthState, AuthStatus> authStatusSelector = (state) {
    return state.status;
  };

  static BlocWidgetSelector<AuthState, String> authUserEmailSelector = (state) {
    return state.user.email ?? '';
  };
}
