import 'package:mockito/mockito.dart';

abstract class MockVoid {
  void call();
}

class MockVoidCallback extends Mock implements MockVoid {}
