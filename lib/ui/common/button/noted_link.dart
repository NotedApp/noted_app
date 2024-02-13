import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore_for_file: use_build_context_synchronously
// coverage:ignore-file
class NotedLink extends StatelessWidget {
  final String url;

  const NotedLink({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme();

    return InkWell(
      onTap: () => _openLink(context),
      borderRadius: BorderRadius.circular(Dimens.radius_m),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.onBackground),
          borderRadius: BorderRadius.circular(Dimens.radius_m),
        ),
        padding: const EdgeInsets.all(Dimens.spacing_s),
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
