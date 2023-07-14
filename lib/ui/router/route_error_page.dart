import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:noted_app/ui/common/button/noted_text_button.dart';
import 'package:noted_app/ui/common/layout/noted_header_page.dart';

class RouteErrorPage extends StatelessWidget {
  const RouteErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    Strings strings = Strings.of(context);

    return NotedHeaderPage(
      hasBackButton: true,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Text(strings.common_routeError),
            SizedBox(height: 12),
            NotedTextButton(
              label: strings.common_routeErrorCta,
              type: NotedTextButtonType.filled,
              onPressed: () => context.go('/'),
            ),
          ],
        ),
      ),
    );
  }
}
