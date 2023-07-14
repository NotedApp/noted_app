import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/routing/noted_go_router.dart';
import 'package:noted_app/util/routing/noted_router.dart';

import '../../helpers/environment/unit_test_environment.dart';
import '../../helpers/mocks/fake_classes.dart';
import '../../helpers/test_wrapper.dart';

class _MockRouter extends Mock implements GoRouter {}

void main() {
  _MockRouter _mockRouter = _MockRouter();

  setUpAll(() {
    UnitTestEnvironment().configure(router: NotedGoRouter());
    registerFallbackValue(FakeBuildContext());

    when(() => _mockRouter.push(captureAny())).thenAnswer((invocation) => Future.value());
    when(() => _mockRouter.pushReplacement(captureAny())).thenAnswer((invocation) => Future.value());
    when(() => _mockRouter.canPop()).thenReturn(true);
  });

  group('NotedGoRouter', () {
    testWidgets('calls build context extensions', (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: InheritedGoRouter(
            goRouter: _mockRouter,
            child: Builder(
              builder: (context) => Column(
                children: [
                  NotedIconButton(
                    icon: NotedIcons.account,
                    type: NotedIconButtonType.filled,
                    onPressed: () => NotedRouterExtensions(context).push('test/route'),
                  ),
                  NotedIconButton(
                    icon: NotedIcons.alarmClock,
                    type: NotedIconButtonType.filled,
                    onPressed: () => NotedRouterExtensions(context).replace('test/route'),
                  ),
                  NotedIconButton(
                    icon: NotedIcons.animation,
                    type: NotedIconButtonType.filled,
                    onPressed: () => NotedRouterExtensions(context).pop('result'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(NotedIcons.account));
      await tester.tap(find.byIcon(NotedIcons.alarmClock));
      await tester.tap(find.byIcon(NotedIcons.animation));

      verify(() => _mockRouter.push('test/route')).called(1);
      verify(() => _mockRouter.pushReplacement('test/route')).called(1);
      verify(() => _mockRouter.pop('result')).called(1);
    });
  });
}
