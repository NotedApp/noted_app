import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_event.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/login/login_loading.dart';
import 'package:noted_app/ui/settings/settings_row.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/routing/noted_router.dart';

const ValueKey _contentKey = const ValueKey('content');
const ValueKey _loadingKey = const ValueKey('loading');

class AccountPage extends StatelessWidget {
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
          AuthStatus.authenticated => _AccountPageContent(email: state.user.email, key: _contentKey),
          _ => LoginLoading(status: state.status, key: _loadingKey),
        },
      ),
    );
  }
}

class _AccountPageContent extends StatelessWidget {
  final String? email;

  const _AccountPageContent({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme();
    final AuthBloc bloc = context.read();
    final Strings strings = context.strings();

    return Column(
      key: _contentKey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        SettingsRow(
          icon: NotedIcons.email,
          title: strings.login_email,
          trailing: Text(
            email ?? strings.common_notAny,
            style: theme.textTheme.labelLarge,
          ),
        ),
        SettingsRow(
          icon: NotedIcons.key,
          title: strings.login_changePassword,
          hasArrow: true,
          onPressed: () => context.push('/settings/account/change-password'),
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
    );
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
