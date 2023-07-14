import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/routing/noted_router.dart';

class RouteErrorPage extends StatelessWidget {
  const RouteErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    Strings strings = Strings.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(),
          NotedImageHeader(title: strings.common_routeErrorTitle),
          Spacer(flex: 2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(strings.common_routeErrorText, textAlign: TextAlign.center),
          ),
          SizedBox(height: 16),
          Align(
            child: NotedTextButton(
              label: strings.common_routeErrorCta,
              type: NotedTextButtonType.filled,
              onPressed: () => context.replace('/'),
            ),
          ),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}
