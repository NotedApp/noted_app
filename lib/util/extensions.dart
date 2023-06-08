import 'package:flutter/material.dart';

extension NotedColorExtensions on Color {
  MaterialStateProperty<Color> materialState() {
    return MaterialStatePropertyAll(this);
  }
}

extension NotedDoubleExtensions on double {
  MaterialStateProperty<double> materialState() {
    return MaterialStatePropertyAll(this);
  }
}

extension NotedEdgeInsetsExtensions on EdgeInsets {
  MaterialStateProperty<EdgeInsets> materialState() {
    return MaterialStatePropertyAll(this);
  }
}

extension NotedSizeExtensions on Size {
  MaterialStateProperty<Size> materialState() {
    return MaterialStatePropertyAll(this);
  }
}

extension NotedOutlinedBorderExtensions on OutlinedBorder {
  MaterialStateProperty<OutlinedBorder> materialState() {
    return MaterialStatePropertyAll(this);
  }
}

extension NotedTextStyleExtensions on TextStyle {
  MaterialStateProperty<TextStyle> materialState() {
    return MaterialStatePropertyAll(this);
  }
}
