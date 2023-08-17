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

class RegisterPage extends StatefulWidget {
  final String initialEmail;
  final String initialPassword;

  RegisterPage({this.initialEmail = '', this.initialPassword = '', super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;
  String? _emailError = null;
  String? _passwordError = null;
  String? _confirmError = null;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController(text: widget.initialEmail);
    _passwordController = TextEditingController(text: widget.initialPassword);
    _confirmController = TextEditingController();

    _emailController.addListener(() => setState(() => _emailError = null));
    _passwordController.addListener(() => setState(() => _passwordError = null));
    _confirmController.addListener(() => setState(() => _confirmError = null));
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read();
    final TextTheme theme = context.textTheme();
    final Strings strings = context.strings();

    return LoginFrame(
      headerTitle: context.strings().login_register,
      stateListener: _handleStateUpdate,
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
          NotedTextField(
            controller: _confirmController,
            name: strings.login_confirmPassword,
            hint: strings.login_confirmPassword,
            errorText: _confirmError,
            showErrorText: true,
            keyboardType: TextInputType.visiblePassword,
            type: NotedTextFieldType.standard,
            autocorrect: false,
            obscureText: !_showPassword,
          ),
          SizedBox(height: 12),
          NotedTextButton(
            label: strings.login_register,
            type: NotedTextButtonType.filled,
            onPressed: () => _tryRegister(context, bloc),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(36, 14, 36, 18),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: strings.login_existingAccount,
                    style: theme.labelSmall,
                  ),
                  TextSpan(
                    text: strings.login_signIn,
                    style: theme.labelSmall?.copyWith(decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()..onTap = () => context.push('/login/sign-in'),
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
    if (state.error != null && (ModalRoute.of(context)?.isCurrent ?? false)) {
      final Strings strings = context.strings();
      String? message;

      switch (state.error!.errorCode) {
        case ErrorCode.auth_createUser_invalidEmail:
          setState(() => _emailError = strings.login_error_createUserInvalidEmail);
        case ErrorCode.auth_createUser_weakPassword:
          setState(() => _passwordError = strings.login_error_weakPassword);
        case ErrorCode.auth_createUser_disabled:
          message = strings.login_error_accountDisabled;
        case ErrorCode.auth_createUser_existingAccount:
          message = strings.login_error_createUserExistingAccount;
        default:
          message = strings.login_error_createUserFailed;
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

  void _tryRegister(BuildContext context, AuthBloc bloc) {
    if (_passwordController.text != _confirmController.text) {
      setState(() => _confirmError = context.strings().login_error_confirmPassword);
      return;
    }

    bloc.add(AuthSignUpWithEmailEvent(_emailController.text, _passwordController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }
}
