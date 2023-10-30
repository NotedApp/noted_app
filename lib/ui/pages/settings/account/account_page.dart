import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_event.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/settings/account/account_frame.dart';
import 'package:noted_app/ui/pages/settings/settings_row.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/util/errors/noted_exception.dart';

// coverage:ignore-file
class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme();
    final AuthBloc bloc = context.watch();
    final Strings strings = context.strings();

    return AccountFrame(
      stateListener: _handleStateUpdate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16),
          SettingsRow(
            icon: NotedIcons.email,
            title: strings.login_email,
            trailing: Text(
              bloc.state.user.email ?? strings.common_notAny,
              style: theme.textTheme.labelLarge,
            ),
          ),
          SettingsRow(
            icon: NotedIcons.key,
            title: strings.login_changePassword,
            hasArrow: true,
            onPressed: () => context.push(SettingsAccountChangePasswordRoute()),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: NotedTextButton(
              label: strings.login_signOut,
              type: NotedTextButtonType.filled,
              onPressed: () => bloc.add(AuthSignOutEvent()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: NotedTextButton(
              label: strings.login_deleteAccount,
              type: NotedTextButtonType.filled,
              onPressed: () => _confirmDeleteAccount(context, strings, bloc),
              foregroundColor: theme.colorScheme.onError,
              backgroundColor: theme.colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }

  void _handleStateUpdate(BuildContext context, AuthState state) {
    if (state.error != null && context.isCurrent()) {
      final Strings strings = context.strings();
      final String message = switch (state.error!.code) {
        ErrorCode.auth_deleteAccount_reauthenticate => strings.login_error_reauthenticate,
        _ => strings.login_error_deleteAccountFailed,
      };

      ScaffoldMessenger.of(context).showSnackBar(
        NotedSnackBar.createWithText(
          context: context,
          text: message,
          hasClose: true,
        ),
      );
    }
  }

  void _confirmDeleteAccount(
    BuildContext context,
    Strings strings,
    AuthBloc bloc,
  ) {
    showDialog(
      context: context,
      builder: (context) => NotedDialog(
        title: strings.login_deleteAccount,
        leftActionText: strings.common_confirm,
        onLeftActionPressed: () {
          bloc.add(AuthDeleteAccountEvent());
          Navigator.of(context).pop();
        },
        leftActionColor: context.colorScheme().error,
        rightActionText: strings.common_cancel,
        onRightActionPressed: () => Navigator.of(context).pop(),
        child: Text(strings.login_deleteAccountWarning),
      ),
    );
  }
}
