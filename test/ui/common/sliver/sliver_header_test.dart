import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/test_wrapper.dart';

void main() {
  group('Sliver Header', () {
    testWidgets('sliver header renders text as expected', (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => CustomScrollView(
              slivers: [
                sliverHeader(context, 'small', size: NotedWidgetSize.small),
                sliverHeader(context, 'medium', size: NotedWidgetSize.medium),
                sliverHeader(context, 'large', size: NotedWidgetSize.large),
              ],
            ),
          ),
        ),
      );

      Finder smallFinder = find.text('small');
      Finder mediumFinder = find.text('medium');
      Finder largeFinder = find.text('large');

      expect(smallFinder, findsOneWidget);
      expect(mediumFinder, findsOneWidget);
      expect(largeFinder, findsOneWidget);
    });
  });
}
