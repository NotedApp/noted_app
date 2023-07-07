import 'package:flutter/material.dart';

class TestWrapper extends StatelessWidget {
  final Widget child;

  const TestWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: child,
      ),
    );
  }
}
