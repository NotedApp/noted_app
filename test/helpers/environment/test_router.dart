import 'package:flutter/material.dart';
import 'package:noted_app/ui/router/noted_router.dart';

class TestRouter extends NotedRouter {
  @override
  void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.of(context).maybePop(result);
  }

  @override
  Future<T?> push<T extends Object?>(BuildContext context, String route) => Future.value();

  @override
  Future<T?> replace<T extends Object?>(BuildContext context, String route) => Future.value();
}
