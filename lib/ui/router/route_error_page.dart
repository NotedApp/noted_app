import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/ui/router/noted_router.dart';

class RouteErrorPage extends StatelessWidget {
  const RouteErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: NotedImageHeader(title: strings.router_errorTitle), flex: 4),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(strings.router_errorText, textAlign: TextAlign.center),
          ),
          SizedBox(height: 16),
          Align(
            child: NotedTextButton(
              label: strings.router_errorCta,
              type: NotedTextButtonType.filled,
              onPressed: () => context.replace('/'),
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
