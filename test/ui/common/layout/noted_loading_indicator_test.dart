import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Loading Indicator', () {
    testWidgets('loading indicator renders as expected', (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: Center(
            child: NotedLoadingIndicator(label: 'test label'),
          ),
        ),
      );

      Finder indicator = find.byType(CircularProgressIndicator);

      expect(find.text('test label'), findsOneWidget);
      expect(indicator, findsOneWidget);
      expect(tester.getSize(indicator), const Size.square(24));
    });
  });
}
