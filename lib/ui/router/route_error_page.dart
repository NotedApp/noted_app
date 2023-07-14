import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/button/noted_text_button.dart';
import 'package:noted_app/ui/common/layout/noted_header_page.dart';
import 'package:noted_app/ui/common/layout/noted_image_header.dart';
import 'package:noted_app/util/routing/noted_router.dart';

class RouteErrorPage extends StatelessWidget {
  const RouteErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    Strings strings = Strings.of(context);

    return NotedHeaderPage(
      hasBackButton: true,
      child: Column(
        children: [
          Spacer(),
          NotedImageHeader(),
          Spacer(flex: 2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(strings.common_routeError, textAlign: TextAlign.center),
          ),
          SizedBox(height: 16),
          NotedTextButton(
            label: strings.common_routeErrorCta,
            type: NotedTextButtonType.filled,
            onPressed: () => context.replace('/'),
          ),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}
