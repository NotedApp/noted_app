import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:noted_app/widget/common/noted_library.dart';

import '../../../helpers/common.dart';
import '../../test_wrapper.dart';

void main() {
  group('Noted Switch Button', () {
    testWidgets('switch button functions as expected', (tester) async {
      const Key trueKey = Key('true');
      const Key falseKey = Key('false');

      MockCallback<bool> trueCallback = MockCallback();
      MockCallback<bool> falseCallback = MockCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              NotedSwitchButton(
                key: trueKey,
                value: true,
                onChanged: trueCallback,
              ),
              NotedSwitchButton(
                key: falseKey,
                value: false,
                onChanged: falseCallback,
              ),
            ],
          ),
        ),
      );

      Finder trueFinder = find.byKey(trueKey);
      Finder falseFinder = find.byKey(falseKey);

      expect(trueFinder, findsOneWidget);
      expect(falseFinder, findsOneWidget);

      await tester.tap(trueFinder);
      await tester.tap(falseFinder);

      verify(trueCallback(captureThat(equals(false)))).called(1);
      verify(falseCallback(captureThat(equals(true)))).called(1);
    });
  });
}
