import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/router_config.dart';
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
          Expanded(flex: 4, child: NotedImageHeader(title: strings.router_errorTitle)),
          const Spacer(),
          NotedErrorWidget(
            text: strings.router_errorText,
            ctaText: strings.router_errorCta,
            ctaCallback: () => context.replace(HomeRoute()),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
