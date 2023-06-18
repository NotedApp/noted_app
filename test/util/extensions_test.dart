import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/util/extensions.dart';

void main() {
  group('Color Extensions', () {
    test('color get black and white returns an appropriate surface color', () {});
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

    test('outlined border material state resolves in all cases', () {
      MaterialStateProperty<TextStyle> property = const TextStyle(fontSize: 7).materialState();
      expect(property.resolve({MaterialState.disabled}).fontSize, 7);
      expect(property.resolve({MaterialState.hovered}).fontSize, 7);
      expect(property.resolve({MaterialState.dragged, MaterialState.pressed}).fontSize, 7);
    });
  });
}
