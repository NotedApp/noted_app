import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/mocks/mock_callbacks.dart';
import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Text Field', () {
    testWidgets('outlined text field produces a string', (tester) async {
      MockCallback<String> onChanged = MockCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: NotedTextField(
            type: NotedTextFieldType.outlined,
            onChanged: onChanged,
          ),
        ),
      );

      Finder input = find.byType(NotedTextField);

      expect(input, findsOneWidget);
      await tester.enterText(input, 'test');

      verify(() => onChanged('test')).called(1);
    });

    testWidgets('title text field produces a string', (tester) async {
      MockCallback<String> onChanged = MockCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: NotedTextField(
            type: NotedTextFieldType.title,
            onChanged: onChanged,
          ),
        ),
      );

      Finder input = find.byType(NotedTextField);

      expect(input, findsOneWidget);
      await tester.enterText(input, 'test');

      verify(() => onChanged('test')).called(1);
    });

    testWidgets('plain text field produces a string', (tester) async {
      MockCallback<String> onChanged = MockCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: NotedTextField(
            type: NotedTextFieldType.plain,
            onChanged: onChanged,
          ),
        ),
      );

      Finder input = find.byType(NotedTextField);

      expect(input, findsOneWidget);
      await tester.enterText(input, 'test');

      verify(() => onChanged('test')).called(1);
    });

    testWidgets('text field handles an icon', (tester) async {
      MockVoidCallback onPressed = MockVoidCallback();

      await tester.pumpWidget(
        TestWrapper(
          child: NotedTextField(
            type: NotedTextFieldType.outlined,
            onChanged: (_) {},
            icon: NotedIcons.pencil,
            onIconPressed: onPressed,
          ),
        ),
      );

      Finder icon = find.byIcon(NotedIcons.pencil);

      expect(icon, findsOneWidget);
      await tester.tap(icon);

      verify(() => onPressed()).called(1);
    });

    testWidgets('text field handles an error', (tester) async {
      String? Function(String?) validator = (value) => value?.contains('error') ?? false ? 'validation' : null;

      await tester.pumpWidget(
        TestWrapper(
          child: NotedTextField(
            type: NotedTextFieldType.outlined,
            showErrorText: true,
            errorText: 'validation',
            validator: validator,
          ),
        ),
      );

      Finder input = find.byType(NotedTextField);
      Finder error = find.text('validation');

      await tester.enterText(input, 'error');
      await tester.pump(const Duration(seconds: 1));
      expect(error, findsOneWidget);
    });
  });
}
