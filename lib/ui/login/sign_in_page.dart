import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_event.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/login/login_frame.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/routing/noted_router.dart';

class SignInPage extends StatefulWidget {
  final String initialEmail;
  final String initialPassword;

  SignInPage({
    this.initialEmail = '',
    this.initialPassword = '',
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  String? _emailError = null;
  String? _passwordError = null;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController(text: widget.initialEmail);
    _passwordController = TextEditingController(text: widget.initialPassword);
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read();
    final TextTheme theme = context.textTheme();
    final Strings strings = context.strings();

    return LoginFrame(
      headerTitle: context.strings().login_signIn,
      contentBuilder: (key) => Column(
        key: key,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 18),
          NotedTextField(
            controller: _emailController,
            name: strings.login_email,
            hint: strings.login_email,
            errorText: _emailError,
            showErrorText: true,
            keyboardType: TextInputType.emailAddress,
            type: NotedTextFieldType.standard,
          ),
          SizedBox(height: 12),
          NotedTextField(
            controller: _passwordController,
            name: strings.login_password,
            hint: strings.login_password,
            errorText: _passwordError,
            showErrorText: true,
            keyboardType: TextInputType.visiblePassword,
            type: NotedTextFieldType.standard,
            autocorrect: false,
            obscureText: !_showPassword,
            icon: _showPassword ? NotedIcons.eyeClosed : NotedIcons.eye,
            onIconPressed: () => setState(() => _showPassword = !_showPassword),
          ),
          SizedBox(height: 12),
          NotedTextButton(
            label: strings.login_signIn,
            type: NotedTextButtonType.filled,
            onPressed: () => bloc.add(
              AuthSignInWithEmailEvent(
                _emailController.text,
                _passwordController.text,
              ),
            ),
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
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _resetPassword(BuildContext context) {
    showUnimplementedSnackBar(context);
  }
}
