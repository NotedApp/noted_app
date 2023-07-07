import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:noted_app/widget/common/noted_library.dart';

import '../../../helpers/common.dart';
import '../../test_wrapper.dart';

void main() {
  group('Noted Tab Bar', () {
    testWidgets('tab bar handles tabs and updates', (tester) async {
      MockCallback<int> onPressed = MockCallback<int>();
      TabController controller = TabController(length: 3, vsync: const TestVSync());

      await tester.pumpWidget(
        TestWrapper(
          child: NotedTabBar(
            tabs: [
              'test 0',
              'test 1',
              'test 2',
            ],
            controller: controller,
            onTap: onPressed,
          ),
        ),
      );

      Finder first = find.text('test 0');
      Finder second = find.text('test 1');
      Finder third = find.text('test 2');

      expect(first, findsOneWidget);
      expect(second, findsOneWidget);
      expect(third, findsOneWidget);

      await tester.tap(second);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      verify(onPressed(captureThat(equals(1)))).called(1);

      await tester.tap(third);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      verify(onPressed(captureThat(equals(2)))).called(1);
    });
  });
}
