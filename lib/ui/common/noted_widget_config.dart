import 'package:flutter/material.dart';

enum NotedWidgetSize {
  large,
  medium,
  small,
}

enum NotedWidgetColor {
  primary,
  secondary,
  tertiary,
}

abstract class NotedWidgetConfig {
  static const double buttonOverlayOpacity = 0.1;

  static const double tileAspectRatio = 0.8;

  static const double tileImageOpacity = 0.2;

  static const ScrollPhysics scrollPhysics = BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  static const double goldenRatio = 1.618;

  static const PageTransitionsTheme transitions = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}
