import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final Strings strings = context.strings();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            NotedImageHeader(),
            RichText(
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
