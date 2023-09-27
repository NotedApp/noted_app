import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/ui/common/custom_colors.dart';
import 'package:noted_app/util/extensions.dart';

void main() {
  group('Color Extensions', () {
    test('color get black and white returns an appropriate surface color', () {
      expect(black.getBW(), white);
      expect(white.getBW(), black);
      expect(red800.getBW(), white);
      expect(yellow200.getBW(), black);
    });

    test('color can be built from a hex string', () {
      expect(NotedColorExtensions.fromHex('#FF000000'), black);
      expect(NotedColorExtensions.fromHex('#FFFFFFFF'), white);
      expect(NotedColorExtensions.fromHex('80000000'), black.withOpacity(0.5));
      expect(NotedColorExtensions.fromHex('F5F5F5'), grey100);
    });

    test('color can converted to a hex string', () {
      expect(black.toHex(), '#ff000000');
      expect(white.toHex(withTag: false), 'ffffffff');
      expect(black.withOpacity(0.5).toHex(), '#80000000');
      expect(grey100.toHex(withTag: false), 'fff5f5f5');
    });

    test('color can have its value updates', () {
      HSVColor original = HSVColor.fromColor(Colors.black);
      HSVColor modified = original.withValue(original.value + 0.2);

      expect(Colors.black.addValue(0.2), modified.toColor());
    });
  });

  group('ThemeData Extensions', () {
    test('theme can have shimmer colors', () {
      ThemeData theme = ThemeData.from(colorScheme: ColorScheme.dark(background: Colors.red));

      expect(theme.shimmerBase(), Colors.red.addValue(0.06));
      expect(theme.shimmerHighlight(), Colors.red.addValue(0.04));
    });
  });

  group('MaterialState Extensions', () {
    test('color material state resolves in all cases', () {
      MaterialStateProperty property = Colors.red.materialState();
      expect(property.resolve({MaterialState.disabled}), Colors.red);
      expect(property.resolve({MaterialState.hovered}), Colors.red);
      expect(property.resolve({MaterialState.dragged, MaterialState.pressed}), Colors.red);
    });

    test('double material state resolves in all cases', () {
      MaterialStateProperty property = 7.toDouble().materialState();
      expect(property.resolve({MaterialState.disabled}), 7);
      expect(property.resolve({MaterialState.hovered}), 7);
      expect(property.resolve({MaterialState.dragged, MaterialState.pressed}), 7);
    });

    test('edge insets material state resolves in all cases', () {
      MaterialStateProperty<EdgeInsets> property = const EdgeInsets.only(top: 7).materialState();
      expect(property.resolve({MaterialState.disabled}).top, 7);
      expect(property.resolve({MaterialState.hovered}).top, 7);
      expect(property.resolve({MaterialState.dragged, MaterialState.pressed}).top, 7);
    });

    test('size material state resolves in all cases', () {
      MaterialStateProperty<Size> property = const Size.square(7).materialState();
      expect(property.resolve({MaterialState.disabled}).width, 7);
      expect(property.resolve({MaterialState.hovered}).height, 7);
      expect(property.resolve({MaterialState.dragged, MaterialState.pressed}).width, 7);
    });

    test('outlined border material state resolves in all cases', () {
      MaterialStateProperty<OutlinedBorder> property = const RoundedRectangleBorder(
        side: BorderSide(width: 7),
      ).materialState();

      expect(property.resolve({MaterialState.disabled}).side.width, 7);
      expect(property.resolve({MaterialState.hovered}).side.width, 7);
      expect(property.resolve({MaterialState.dragged, MaterialState.pressed}).side.width, 7);
    });

    test('text style material state resolves in all cases', () {
      MaterialStateProperty<TextStyle> property = const TextStyle(fontSize: 7).materialState();
      expect(property.resolve({MaterialState.disabled}).fontSize, 7);
      expect(property.resolve({MaterialState.hovered}).fontSize, 7);
      expect(property.resolve({MaterialState.dragged, MaterialState.pressed}).fontSize, 7);
    });
  });
}
