import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_event.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/login/login_frame.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_app/ui/router/noted_router.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginFrame(
      hasBackButton: false,
      contentTitle: context.strings().app_title,
      contentBuilder: (key) => _LoginPageContent(key: key),
      stateListener: _handleStateUpdate,
    );
  }

  void _handleStateUpdate(BuildContext context, AuthState state) {
    if (state.error != null && context.isCurrent()) {
      final Strings strings = context.strings();
      final String message = switch (state.error!.code) {
        ErrorCode.auth_googleSignIn_disabled => strings.login_error_accountDisabled,
        ErrorCode.auth_googleSignIn_existingAccount => strings.login_error_googleSignExistingAccount,
        ErrorCode.auth_googleSignIn_failed => strings.login_error_googleSignInFailed,
        _ => strings.login_error_signInFailed,
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
}

class _LoginPageContent extends StatelessWidget {
  const _LoginPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read();
    final TextTheme theme = context.textTheme();
    final Strings strings = context.strings();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 18),
        NotedTextButton(
          label: strings.login_signIn,
          type: NotedTextButtonType.filled,
          onPressed: () => context.push('/login/sign-in'),
        ),
        SizedBox(height: 12),
        NotedTextButton(
          label: strings.login_register,
          type: NotedTextButtonType.filled,
          color: NotedWidgetColor.secondary,
          onPressed: () => context.push('/login/register'),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Divider(indent: 2, endIndent: 10)),
            Text(strings.login_signInWith, style: theme.bodySmall),
            Expanded(child: Divider(indent: 10, endIndent: 2)),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NotedIconButton(
              icon: NotedIcons.google,
              type: NotedIconButtonType.filled,
              color: NotedWidgetColor.secondary,
              onPressed: () => bloc.add(AuthSignInWithGoogleEvent()),
            ),
            NotedIconButton(
              icon: NotedIcons.apple,
              type: NotedIconButtonType.filled,
              color: NotedWidgetColor.secondary,
              onPressed: () => showUnimplementedSnackBar(context),
            ),
            NotedIconButton(
              icon: NotedIcons.facebook,
              type: NotedIconButtonType.filled,
              color: NotedWidgetColor.secondary,
              onPressed: () => showUnimplementedSnackBar(context),
            ),
            NotedIconButton(
              icon: NotedIcons.github,
              type: NotedIconButtonType.filled,
              color: NotedWidgetColor.secondary,
              onPressed: () => showUnimplementedSnackBar(context),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 36, vertical: 20),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: strings.login_disclaimers,
                  style: theme.labelSmall,
                ),
                TextSpan(
                  text: strings.login_termsOfUse,
                  style: theme.labelSmall?.copyWith(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()..onTap = () => _viewTermsOfUse(context),
                ),
                TextSpan(
                  text: strings.login_and,
                  style: theme.labelSmall,
                ),
                TextSpan(
                  text: strings.login_privacyPolicy,
                  style: theme.labelSmall?.copyWith(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()..onTap = () => _viewPrivacyPolicy(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _viewTermsOfUse(BuildContext context) {
    showUnimplementedSnackBar(context);
  }

  void _viewPrivacyPolicy(BuildContext context) {
    showUnimplementedSnackBar(context);
  }
}
