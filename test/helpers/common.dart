import 'package:mockito/mockito.dart';

abstract class _MockVoidCallback {
  void call();
}

class MockVoidCallback extends Mock implements _MockVoidCallback {}

abstract class _MockBoolCallback {
  void call(bool);
}

class MockBoolCallback extends Mock implements _MockBoolCallback {}
