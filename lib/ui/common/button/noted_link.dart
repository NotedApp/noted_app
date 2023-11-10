import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/layout/layout.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class NotedLink extends StatelessWidget {
  final String url;

  const NotedLink({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme();

    return InkWell(
      onTap: () => _openLink(context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.onBackground),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Text(
          url,
          style: theme.textTheme.labelLarge?.copyWith(decoration: TextDecoration.underline),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Future<void> _openLink(BuildContext context) async {
    try {
      final Uri uri = Uri.parse(url);

      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    } catch (_) {
      if (context.isCurrent()) {
        ScaffoldMessengerState? state = ScaffoldMessenger.maybeOf(context);

        state?.showSnackBar(
          NotedSnackBar.createWithText(
            context: context,
            text: context.strings().common_error_linkFormat,
            hasClose: true,
          ),
        );
      }
    }
  }
}
