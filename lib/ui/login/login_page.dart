import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_event.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/routing/noted_router.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read();
    final TextTheme theme = context.textTheme();
    final Strings strings = context.strings();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: NotedImageHeader()),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: NotedTextButton(
                label: strings.login_signIn,
                type: NotedTextButtonType.filled,
                onPressed: () => context.push('sign-in'),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: NotedTextButton(
                label: strings.login_register,
                type: NotedTextButtonType.filled,
                color: NotedWidgetColor.secondary,
                onPressed: () => context.push('register'),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider(indent: 22, endIndent: 10)),
                  Text(strings.login_signInWith, style: theme.bodySmall),
                  Expanded(child: Divider(indent: 10, endIndent: 22)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
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
                    onPressed: () => NotedSnackBar.showUnimplementedSnackBar(context),
                  ),
                  NotedIconButton(
                    icon: NotedIcons.facebook,
                    type: NotedIconButtonType.filled,
                    color: NotedWidgetColor.secondary,
                    onPressed: () => NotedSnackBar.showUnimplementedSnackBar(context),
                  ),
                  NotedIconButton(
                    icon: NotedIcons.github,
                    type: NotedIconButtonType.filled,
                    color: NotedWidgetColor.secondary,
                    onPressed: () => NotedSnackBar.showUnimplementedSnackBar(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 84, vertical: 20),
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
        ),
      ),
    );
  }

  void _viewTermsOfUse(BuildContext context) {
    NotedSnackBar.showUnimplementedSnackBar(context);
  }

  void _viewPrivacyPolicy(BuildContext context) {
    NotedSnackBar.showUnimplementedSnackBar(context);
  }
}
