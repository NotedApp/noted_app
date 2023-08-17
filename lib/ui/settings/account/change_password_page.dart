import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme();
    final AuthBloc bloc = context.read();
    final Strings strings = context.strings();

    return AccountFrame(
      stateListener: _handleStateUpdate,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [],
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
}
