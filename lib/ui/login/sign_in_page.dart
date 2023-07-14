import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/login/login_loading.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/routing/noted_router.dart';

const ValueKey _contentKey = const ValueKey('content');
const ValueKey _loadingKey = const ValueKey('loading');

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotedHeaderPage(
      hasBackButton: true,
      title: context.strings().login_signIn,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            context.replace('/');
          }
        },
        builder: (context, state) => Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (Widget child, Animation<double> animation) => SlideTransition(
              position: Tween(
                begin: child.key == _contentKey ? Offset(-1.0, 0.0) : Offset(1.0, 0.0),
                end: Offset(0.0, 0.0),
              ).animate(animation),
              child: child,
            ),
            child: switch (state.status) {
              AuthStatus.unauthenticated => _SignInPageContent(),
              _ => LoginLoading(status: state.status, key: _loadingKey),
            },
          ),
        ),
      ),
    );
  }
}

class _SignInPageContent extends StatefulWidget {
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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
      ),
    );
  }

  void _resetPassword(BuildContext context) {
    NotedSnackBar.showUnimplementedSnackBar(context);
  }
}
