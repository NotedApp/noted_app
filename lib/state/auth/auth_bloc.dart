import 'package:noted_app/state/auth/auth_event.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/state/noted_bloc.dart';

class AuthBloc extends NotedBloc<AuthEvent, AuthState> {
  AuthBloc(AuthState initialState) : super(initialState, 'auth');
}
