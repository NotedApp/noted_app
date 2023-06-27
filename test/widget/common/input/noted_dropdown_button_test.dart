import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:noted_app/widget/common/input/input.dart';

import '../../../helpers/common.dart';
import '../../test_wrapper.dart';

void main() {
  group('Noted Dropdown Button', () {
    testWidgets('dropdown button renders all items and selects one', (tester) async {
      MockCallback<String> onSelect = MockCallback<String>();
      String initial = '1';
      List<String> values = ['0', '1', '2', '3', '4'];

      await tester.pumpWidget(
        TestWrapper(
          child: NotedDropdownButton(
            value: initial,
            items: values,
            onChanged: onSelect,
          ),
        ),
      );

      Finder button = find.byType(DropdownButtonFormField<String>);
      await tester.tap(button);
      await tester.pump(const Duration(seconds: 1));

      // The initial item is counted as an item.
      Finder items = find.byType(DropdownMenuItem<String>);
      expect(items, findsNWidgets(6));

      await tester.tap(items.at(1), warnIfMissed: false);
      await tester.pump(const Duration(seconds: 1));

      verify(onSelect(captureThat(equals('0')))).called(1);
    });
  });
}
