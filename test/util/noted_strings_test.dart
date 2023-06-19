import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/util/noted_strings.dart';

void main() {
  group('Noted Strings', () {
    test('string get handles all cases', () {
      expect(NotedStrings.getString(NotedStringDomain.common, 'confirm'), 'confirm');
      expect(NotedStrings.getString(NotedStringDomain.common, 'cancel'), 'cancel');
      expect(NotedStrings.getString(NotedStringDomain.common, 'random'), 'unknown');

      expect(NotedStrings.getString(NotedStringDomain.settings, 'colorTitle'), 'colors');

      expect(NotedStrings.getString(NotedStringDomain.editor, 'linkPickerTitle'), 'link to');
    });
  });
}
