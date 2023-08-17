import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/login/login_loading.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/ui/router/noted_router.dart';

class AccountFrame extends StatelessWidget {
  final Widget child;

  const AccountFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    return NotedHeaderPage(
      hasBackButton: true,
      title: context.strings().settings_accountTitle,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            context.replace('/login');
          }
        },
        builder: (context, state) => switch (state.status) {
          AuthStatus.authenticated => child,
          _ => LoginLoading(status: state.status),
        },
      ),
    );
  }
}
