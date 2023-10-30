import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Scroll Mask', () {
    testWidgets('scroll mask renders as expected', (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: Column(
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: NotedScrollMask(
                  child: Text('noted tile'),
                  direction: Axis.horizontal,
                  size: 16,
                ),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: NotedScrollMask(
                  child: Text('noted tile'),
                  direction: Axis.vertical,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      );

      expect(find.byType(ShaderMask), findsNWidgets(2));
    });
  });
}
