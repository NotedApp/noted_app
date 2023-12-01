import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Scroll Mask', () {
    testWidgets('scroll mask renders as expected', (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: const Column(
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: NotedScrollMask(
                  direction: Axis.horizontal,
                  size: 16,
                  child: Text('noted tile'),
                ),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: NotedScrollMask(
                  direction: Axis.vertical,
                  size: 16,
                  child: Text('noted tile'),
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
