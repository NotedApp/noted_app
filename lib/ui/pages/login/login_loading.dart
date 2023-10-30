import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';

// coverage:ignore-file
class LoginLoading extends StatelessWidget {
  final AuthStatus status;

  const LoginLoading({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    final Strings strings = context.strings();

    return Center(
      child: NotedLoadingIndicator(
        label: switch (status) {
          AuthStatus.unauthenticated => strings.login_signedOut,
          AuthStatus.authenticated => strings.login_authenticated,
          AuthStatus.signingOut => strings.login_signingOut,
          AuthStatus.signingIn => strings.login_signingIn,
          AuthStatus.signingUp => strings.login_signingUp,
          AuthStatus.sendingPasswordReset => strings.login_sendingPasswordReset,
          AuthStatus.changingPassword => strings.login_changingPassword,
          AuthStatus.deletingAccount => strings.login_deletingAccount,
        },
      ),
    );
  }
}
