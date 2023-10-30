import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';

import '../../helpers/environment/unit_test_environment.dart';
import '../../helpers/mocks/mock_classes.dart';
import '../../helpers/test_wrapper.dart';

class _FakeBuildContext extends Fake implements BuildContext {}

void main() {
  MockRouter _mockRouter = MockRouter();

  setUpAll(() async {
    await UnitTestEnvironment().configure(router: _mockRouter);
    registerFallbackValue(_FakeBuildContext());
    registerFallbackValue(LoginRoute());

    when(() => _mockRouter.push(captureAny(), captureAny())).thenAnswer((invocation) => Future.value());
    when(() => _mockRouter.replace(captureAny(), captureAny())).thenAnswer((invocation) => Future.value());
  });

  group('NotedRouter', () {
    testWidgets('calls build context extensions', (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: Builder(
            builder: (context) => Column(
              children: [
                NotedIconButton(
                  icon: NotedIcons.account,
                  type: NotedIconButtonType.filled,
                  onPressed: () => context.push(SettingsAccountRoute()),
                ),
                NotedIconButton(
                  icon: NotedIcons.brush,
                  type: NotedIconButtonType.filled,
                  onPressed: () => context.replace(SettingsStyleRoute()),
                ),
                NotedIconButton(
                  icon: NotedIcons.animation,
                  type: NotedIconButtonType.filled,
                  onPressed: () => context.pop('result'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(NotedIcons.account));
      await tester.tap(find.byIcon(NotedIcons.brush));
      await tester.tap(find.byIcon(NotedIcons.animation));

      verify(() => _mockRouter.push(captureAny(), SettingsAccountRoute())).called(1);
      verify(() => _mockRouter.replace(captureAny(), SettingsStyleRoute())).called(1);
      verify(() => _mockRouter.pop(captureAny(), 'result')).called(1);
    });
  });
}
