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
    final ThemeData theme = context.theme();
    final Strings strings = context.strings();
    final AuthBloc bloc = context.read();

    return NotedHeaderPage(
      hasBackButton: true,
      title: strings.settings_accountTitle,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            context.replace('/login');
          }
        },
        builder: (context, state) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (Widget child, Animation<double> animation) => SlideTransition(
            position: Tween(
              begin: child.key == _contentKey ? Offset(-1.0, 0.0) : Offset(1.0, 0.0),
              end: Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          ),
          child: switch (state.status) {
            AuthStatus.authenticated => Column(
                key: _contentKey,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16),
                  SettingsRow(
                    icon: NotedIcons.email,
                    title: strings.login_email,
                    trailing: Text(
                      state.user.email ?? strings.common_notAny,
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
                      onPressed: () => showUnimplementedSnackBar(context),
                      foregroundColor: theme.colorScheme.onError,
                      backgroundColor: theme.colorScheme.error,
                    ),
                  ),
                ],
              ),
            _ => LoginLoading(status: state.status, key: _loadingKey),
          },
        ),
      ),
    );
  }
}
