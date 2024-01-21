import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/test_wrapper.dart';

void main() {
  group('Stroked Test', () {
    testWidgets('stroked text renders text as expected', (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: const StrokedText('test'),
        ),
      );

      Finder smallFinder = find.text('test');
      expect(smallFinder, findsNWidgets(2));
    });
  });
}
