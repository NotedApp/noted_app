import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_event.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/login/login_frame.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_app/ui/router/noted_router.dart';

// coverage:ignore-file
class SignInPage extends StatefulWidget {
  final String initialEmail;
  final String initialPassword;

  const SignInPage({
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
  String? _emailError;
  String? _passwordError;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController(text: widget.initialEmail);
    _passwordController = TextEditingController(text: widget.initialPassword);

    _emailController.addListener(() => setState(() => _emailError = null));
    _passwordController.addListener(() => setState(() => _passwordError = null));
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.watch();
    final TextTheme theme = context.textTheme();
    final Strings strings = context.strings();

    return LoginFrame(
      headerTitle: context.strings().login_signIn,
      stateListener: _handleStateUpdate,
      contentBuilder: (key) => Column(
        key: key,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 18),
          NotedTextField(
            controller: _emailController,
            name: strings.login_email,
            hint: strings.login_email,
            errorText: _emailError,
            showErrorText: true,
            keyboardType: TextInputType.emailAddress,
            type: NotedTextFieldType.outlined,
          ),
          const SizedBox(height: 12),
          NotedTextField(
            controller: _passwordController,
            name: strings.login_password,
            hint: strings.login_password,
            errorText: _passwordError,
            showErrorText: true,
            keyboardType: TextInputType.visiblePassword,
            type: NotedTextFieldType.outlined,
            autocorrect: false,
            obscureText: !_showPassword,
            icon: _showPassword ? NotedIcons.eyeClosed : NotedIcons.eye,
            onIconPressed: () => setState(() => _showPassword = !_showPassword),
          ),
          const SizedBox(height: 12),
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
          const SizedBox(height: 12),
          NotedTextButton(
            label: strings.login_register,
            type: NotedTextButtonType.filled,
            color: NotedWidgetColor.secondary,
            onPressed: () => context.push(LoginRegisterRoute()),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(36, 14, 36, 18),
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
                    recognizer: TapGestureRecognizer()..onTap = () => context.push(LoginResetPasswordRoute()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleStateUpdate(BuildContext context, AuthState state) {
    if (state.error != null && context.isCurrent()) {
      final Strings strings = context.strings();
      String? message;

      switch (state.error!.code) {
        case ErrorCode.auth_emailSignIn_invalidEmail:
          setState(() => _emailError = strings.login_error_emailSignInInvalidEmail);
        case ErrorCode.auth_emailSignIn_invalidPassword:
          setState(() => _passwordError = strings.login_error_emailSignInInvalidPassword);
        case ErrorCode.auth_emailSignIn_disabled:
          message = strings.login_error_accountDisabled;
        default:
          message = strings.login_error_signInFailed;
      }

      if (message != null) {
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
