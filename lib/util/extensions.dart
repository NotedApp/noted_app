import 'package:flutter/material.dart';
import 'package:noted_app/theme/custom_colors.dart';

extension NotedColorExtensions on Color {
  MaterialStateProperty<Color> materialState() {
    return MaterialStatePropertyAll(this);
  }

  /// Returns black or white, depending on the intensity of the color. This value can be used to generate a dynamic on
  /// surface color for the given color.
  Color getBW() {
    return (red * 0.3 + green * 0.6 + blue * 0.1) > 186 ? black : white;
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
