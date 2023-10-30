import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noted_app/util/debouncer.dart';

import '../helpers/mocks/mock_callbacks.dart';

void main() {
  group('Debouncer', () {
    test('debounces with run first', () async {
      MockVoidCallback action = MockVoidCallback();
      Debouncer debouncer = Debouncer(interval: const Duration(milliseconds: 10), runFirst: true);

      expectLater(debouncer.activeStream, emitsInOrder([false, true, false]));

      debouncer.run(action);
      debouncer.run(action);
      debouncer.run(action);
      expect(debouncer.isActive, true);
      verify(() => action()).called(1);

      await Future.delayed(const Duration(milliseconds: 15));
      expect(debouncer.isActive, false);

      debouncer.run(action);
      verify(() => action()).called(1);
      expect(debouncer.isActive, true);

      debouncer.dispose();
    });

    test('debounces with run later', () async {
      MockVoidCallback action = MockVoidCallback();
      Debouncer debouncer = Debouncer(interval: const Duration(milliseconds: 10));

      expectLater(debouncer.activeStream, emitsInOrder([false, true, true, true, false, true]));

      debouncer.run(action);
      debouncer.run(action);
      debouncer.run(action);
      expect(debouncer.isActive, true);
      verifyNever(() => action());

      await Future.delayed(const Duration(milliseconds: 15));
      expect(debouncer.isActive, false);
      verify(() => action()).called(1);

      debouncer.run(action);
      expect(debouncer.isActive, true);
      verifyNever(() => action());

      debouncer.dispose();
    });
  });
}
