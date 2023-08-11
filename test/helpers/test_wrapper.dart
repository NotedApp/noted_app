import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestWrapper extends StatelessWidget {
  final Widget child;

  const TestWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: Strings.localizationsDelegates,
      supportedLocales: Strings.supportedLocales,
      home: Material(child: child),
    );
  }
}
