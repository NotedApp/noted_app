import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/router/route_error_page.dart';

import '../../helpers/environment/unit_test_environment.dart';
import '../../helpers/mocks/fake_classes.dart';
import '../../helpers/mocks/mock_classes.dart';
import '../../helpers/test_wrapper.dart';

void main() {
  group('Route Error Page', () {
    MockRouter _mockRouter = MockRouter();

    setUpAll(() {
      UnitTestEnvironment().configure(router: _mockRouter);
      registerFallbackValue(FakeBuildContext());
      when(() => _mockRouter.replace(captureAny(), captureAny())).thenAnswer((invocation) => Future.value());
    });

    testWidgets('error page renders a header, image, text, and home button', (tester) async {
      await tester.pumpWidget(TestWrapper(child: RouteErrorPage()));

      Finder action = find.text('back to home');

      await tester.tap(action);

      expect(find.text('oops!'), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.text('sorry, we seem to be lost!'), findsOneWidget);
      expect(action, findsOneWidget);

      verify(() => _mockRouter.replace(captureAny(), '/')).called(1);
    });
  });
}
