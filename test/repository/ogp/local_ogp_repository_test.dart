import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/repository/ogp/local_ogp_repository.dart';

void main() {
  late LocalOgpRepository ogp;

  setUp(() {
    ogp = LocalOgpRepository();
    ogp.msDelay = 1;
  });

  group('LocalOgpRepository', () {
    test('fetches image URL and resets', () async {
      ogp.imageUrl = 'test-url';
      expect(await ogp.fetchImage('url'), 'test-url');

      ogp.reset();
      ogp.msDelay = 1;
      expect(await ogp.fetchImage('url'), '');
    });
  });
}
