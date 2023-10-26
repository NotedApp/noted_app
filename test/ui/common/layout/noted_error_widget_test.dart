import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Error Widget', () {
    testWidgets('error widget renders a title, text, and cta', (tester) async {
      MockVoidCallback cta = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: NotedErrorWidget(
            title: 'title',
            text: 'text',
            ctaText: 'cta',
            ctaCallback: cta,
          ),
        ),
      );

      Finder button = find.text('cta');

      await tester.tap(button);

      expect(find.text('title'), findsOneWidget);
      expect(find.text('text'), findsOneWidget);
      expect(button, findsOneWidget);

      verify(() => cta()).called(1);
    });
  });
}
