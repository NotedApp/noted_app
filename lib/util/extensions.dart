import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  static Color fromHex(String hexString) {
    StringBuffer buffer = StringBuffer();

    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }

    buffer.write(hexString.replaceFirst('#', ''));
    int? value = int.tryParse(buffer.toString(), radix: 16);

    if (value == null) {
      return black;
    }

    return Color(value);
  }

  String toHex({bool withTag = true}) {
    StringBuffer buffer = StringBuffer();

    if (withTag) {
      buffer.write('#');
    }

    buffer.write(alpha.toRadixString(16).padLeft(2, '0'));
    buffer.write(red.toRadixString(16).padLeft(2, '0'));
    buffer.write(green.toRadixString(16).padLeft(2, '0'));
    buffer.write(blue.toRadixString(16).padLeft(2, '0'));
    return buffer.toString();
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

// coverage:ignore-start
extension NotedBuildContextExtensions on BuildContext {
  Strings strings() {
    return Strings.of(this);
  }

  ThemeData theme() {
    return Theme.of(this);
  }

  TextTheme textTheme() {
    return Theme.of(this).textTheme;
  }

  ColorScheme colorScheme() {
    return Theme.of(this).colorScheme;
  }
}
// coverage:ignore-end
