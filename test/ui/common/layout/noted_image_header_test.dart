import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/environment/unit_test_environment.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Image Header', () {
    setUpAll(() {
      UnitTestEnvironment().configure();
    });

    testWidgets('header renders a title and image', (tester) async {
      await tester.pumpWidget(TestWrapper(child: const NotedImageHeader(title: 'noted.')));

      expect(find.text('noted.'), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}
