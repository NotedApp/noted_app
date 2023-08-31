import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_event.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/login/login_frame.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/errors/noted_exception.dart';

class PasswordResetPage extends StatefulWidget {
  final String initialEmail;

  PasswordResetPage({this.initialEmail = '', super.key});

  @override
  State<StatefulWidget> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  late final TextEditingController _emailController;
  String? _emailError = null;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController(text: widget.initialEmail);

    _emailController.addListener(() => setState(() => _emailError = null));
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.watch();
    final Strings strings = context.strings();

    return LoginFrame(
      headerTitle: context.strings().login_register,
      stateListener: _handleStateUpdate,
      contentBuilder: (key) => Column(
        key: key,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 18),
          Text(strings.login_resetPasswordBody),
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
          NotedTextButton(
            label: strings.login_resetPasswordCta,
            type: NotedTextButtonType.filled,
            onPressed: () => bloc.add(AuthSendPasswordResetEvent(_emailController.text)),
          )
        ],
      ),
    );
  }

  void _handleStateUpdate(BuildContext context, AuthState state) {
    if (state.error != null && context.isCurrent()) {
      final Strings strings = context.strings();
      String? message;

      switch (state.error!.code) {
        case ErrorCode.auth_passwordReset_invalidEmail:
          setState(() => _emailError = strings.login_error_passwordResetInvalidEmail);
        default:
          message = strings.login_error_passwordResetFailed;
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
    super.dispose();
  }
}
