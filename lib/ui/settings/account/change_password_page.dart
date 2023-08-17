import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_event.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/settings/account/account_frame.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/noted_exception.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage();

  @override
  State<StatefulWidget> createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;
  String? _confirmError = null;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();

    _passwordController = TextEditingController();
    _confirmController = TextEditingController();

    _confirmController.addListener(() => setState(() => _confirmError = null));
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = context.read();
    final Strings strings = context.strings();

    return AccountFrame(
      stateListener: _handleStateUpdate,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NotedTextField(
              controller: _passwordController,
              name: strings.login_password,
              hint: strings.login_password,
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
              label: strings.login_changePassword,
              type: NotedTextButtonType.filled,
              onPressed: () => _tryChangePassword(context, bloc),
            ),
          ],
        ),
      ),
    );
  }

  void _handleStateUpdate(BuildContext context, AuthState state) {
    if (state.error != null && (ModalRoute.of(context)?.isCurrent ?? false)) {
      final Strings strings = context.strings();
      final String message = switch (state.error!.errorCode) {
        ErrorCode.auth_changePassword_reauthenticate => strings.login_error_reauthenticate,
        ErrorCode.auth_changePassword_weakPassword => strings.login_error_weakPassword,
        _ => strings.login_error_changePasswordFailed,
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

  void _tryChangePassword(BuildContext context, AuthBloc bloc) {
    if (_passwordController.text != _confirmController.text) {
      setState(() => _confirmError = context.strings().login_error_confirmPassword);
      return;
    }

    bloc.add(AuthChangePasswordEvent(_passwordController.text));
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }
}
