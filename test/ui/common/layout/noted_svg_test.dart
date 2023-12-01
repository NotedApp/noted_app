import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted SVG', () {
    testWidgets('svg renders as expected', (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: const NotedSvg.asset(source: 'assets/svg/man_computer.svg', fit: BoxFit.fill),
        ),
      );

      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}
