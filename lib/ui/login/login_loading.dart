import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';

class LoginLoading extends StatelessWidget {
  final AuthStatus status;

  const LoginLoading({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    final Strings strings = context.strings();

    return Center(
      child: NotedLoadingIndicator(
        label: switch (status) {
          AuthStatus.unauthenticated => strings.unknown,
          AuthStatus.authenticated => strings.login_authenticated,
          AuthStatus.signing_out => strings.login_signingOut,
          AuthStatus.signing_in => strings.login_signingIn,
          AuthStatus.signing_up => strings.login_signingUp,
          AuthStatus.sending_password_reset => strings.login_sendingPasswordReset,
        },
      ),
    );
  }
}
