import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/theme/custom_colors.dart';
import 'package:noted_models/noted_models.dart';

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

extension NotedBrightnessExtensions on NotedBrightness {
  Brightness toMaterial() {
    return switch (this) {
      NotedBrightness.light => Brightness.light,
      _ => Brightness.dark,
    };
  }
}

extension NotedColorSchemeExtensions on NotedColorScheme {
  ColorScheme toMaterial() {
    return ColorScheme(
      brightness: brightness.toMaterial(),
      primary: Color(primary),
      onPrimary: Color(onPrimary),
      secondary: Color(secondary),
      onSecondary: Color(onSecondary),
      tertiary: Color(tertiary),
      onTertiary: Color(onTertiary),
      error: Color(error),
      onError: Color(onError),
      background: Color(background),
      onBackground: Color(onBackground),
      surface: Color(surface),
      onSurface: Color(onSurface),
    );
  }
}

extension NotedTextThemeExtensions on NotedTextTheme {
  TextTheme toMaterial() {
    return TextTheme(
      displayLarge: TextStyle(fontFamily: fontFamily, fontSize: 57, height: 64 / 57, fontWeight: FontWeight.normal),
      displayMedium: TextStyle(fontFamily: fontFamily, fontSize: 45, height: 52 / 45, fontWeight: FontWeight.normal),
      displaySmall: TextStyle(fontFamily: fontFamily, fontSize: 36, height: 44 / 36, fontWeight: FontWeight.normal),
      headlineLarge: TextStyle(fontFamily: fontFamily, fontSize: 32, height: 40 / 32, fontWeight: FontWeight.normal),
      headlineMedium: TextStyle(fontFamily: fontFamily, fontSize: 28, height: 36 / 28, fontWeight: FontWeight.normal),
      headlineSmall: TextStyle(fontFamily: fontFamily, fontSize: 24, height: 32 / 24, fontWeight: FontWeight.normal),
      titleLarge: TextStyle(fontFamily: fontFamily, fontSize: 22, height: 28 / 22, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontFamily: fontFamily, fontSize: 18, height: 24 / 18, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontFamily: fontFamily, fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w500),
      labelLarge: TextStyle(fontFamily: fontFamily, fontSize: 14, height: 20 / 14, fontWeight: FontWeight.normal),
      labelMedium: TextStyle(fontFamily: fontFamily, fontSize: 12, height: 16 / 12, fontWeight: FontWeight.normal),
      labelSmall: TextStyle(fontFamily: fontFamily, fontSize: 11, height: 16 / 11, fontWeight: FontWeight.normal),
      bodyLarge: TextStyle(fontFamily: fontFamily, fontSize: 16, height: 24 / 16, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontFamily: fontFamily, fontSize: 14, height: 20 / 14, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontFamily: fontFamily, fontSize: 12, height: 16 / 12, fontWeight: FontWeight.normal),
    );
  }
}
// coverage:ignore-end
