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

class RegisterPage extends StatelessWidget {
  final String initialEmail;
  final String initialPassword;

  const RegisterPage({
    this.initialEmail = '',
    this.initialPassword = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LoginFrame(
      headerTitle: context.strings().login_register,
      contentBuilder: (key) => _RegisterPageContent(
        initialEmail: initialEmail,
        initialPassword: initialPassword,
        key: key,
      ),
    );
  }
}

class _RegisterPageContent extends StatefulWidget {
  final String initialEmail;
  final String initialPassword;

  _RegisterPageContent({this.initialEmail = '', this.initialPassword = '', super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageContentState();
}

class _RegisterPageContentState extends State<_RegisterPageContent> {
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

    _confirmController.addListener(() {
      if (_confirmError != null) {
        setState(() => _confirmError = null);
      }
    });
  }

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
          color: NotedWidgetColor.secondary,
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
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _tryRegister(BuildContext context, AuthBloc bloc) {
    if (_passwordController.text != _confirmController.text) {
      setState(() => _confirmError = context.strings().login_error_confirmPassword);
      return;
    }

    bloc.add(AuthSignUpWithEmailEvent(_emailController.text, _passwordController.text));
  }
}
