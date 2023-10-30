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

  static const ScrollPhysics scrollPhysics = BouncingScrollPhysics();
}

class NotedPadding {
  static const double xxxs = 2;
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 36;
  static const double xxxl = 48;
  static const double xxxxl = 64;
}
