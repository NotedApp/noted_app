import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noted_app/ui/common/noted_library.dart';

import '../../../helpers/test_wrapper.dart';

void main() {
  group('Noted Image', () {
    testWidgets('noted image renders image as expected', (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: const NotedImage.network(
            source: 'test.com',
            fit: BoxFit.cover,
          ),
        ),
      );

      Finder smallFinder = find.byType(CachedNetworkImage);
      expect(smallFinder, findsOneWidget);
    });
  });
}
