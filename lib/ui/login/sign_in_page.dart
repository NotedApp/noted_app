import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/login/login_frame.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/routing/noted_router.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginFrame(
      headerTitle: context.strings().login_signIn,
      contentBuilder: (key) => _SignInPageContent(key: key),
    );
  }
}

class _SignInPageContent extends StatefulWidget {
  _SignInPageContent({super.key});

  @override
  State<StatefulWidget> createState() => _SignInPageContentState();
}

class _SignInPageContentState extends State<_SignInPageContent> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read();
    final TextTheme theme = context.textTheme();
    final Strings strings = context.strings();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 18),
        NotedTextField(
          name: strings.login_email,
          hint: strings.login_email,
          keyboardType: TextInputType.emailAddress,
          type: NotedTextFieldType.standard,
        ),
        SizedBox(height: 12),
        NotedTextField(
          name: strings.login_password,
          hint: strings.login_password,
          keyboardType: TextInputType.visiblePassword,
          type: NotedTextFieldType.standard,
          obscureText: true,
          autocorrect: false,
        ),
        SizedBox(height: 12),
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
        Padding(
          padding: EdgeInsets.fromLTRB(36, 14, 36, 18),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: strings.login_forgotPassword,
                  style: theme.labelSmall,
                ),
                TextSpan(
                  text: strings.login_resetPassword,
                  style: theme.labelSmall?.copyWith(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()..onTap = () => _resetPassword(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _resetPassword(BuildContext context) {
    NotedSnackBar.showUnimplementedSnackBar(context);
  }
}
