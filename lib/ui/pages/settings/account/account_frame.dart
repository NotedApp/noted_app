import 'package:flutter/material.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/login/login_loading.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_app/ui/router/noted_router.dart';

// coverage:ignore-file
class AccountFrame extends StatelessWidget {
  final Widget child;
  final void Function(BuildContext, AuthState)? stateListener;

  const AccountFrame({super.key, required this.child, this.stateListener});

  @override
  Widget build(BuildContext context) {
    return NotedHeaderPage(
      hasBackButton: true,
      title: context.strings().settings_account_title,
      child: NotedBlocSelector<AuthBloc, AuthState, AuthStatus>(
        selector: (state) => state.status,
        listener: stateListener,
        selectedListener: (context, state) {
          if (state == AuthStatus.unauthenticated) {
            context.replace(LoginRoute());
          }
        },
        builder: (context, _, state) => switch (state) {
          AuthStatus.authenticated => child,
          _ => LoginLoading(status: state),
        },
      ),
    );
  }
}
