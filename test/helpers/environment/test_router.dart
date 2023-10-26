import 'package:flutter/material.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';

class TestRouter extends NotedRouter {
  @override
  void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.of(context).maybePop(result);
  }

  @override
  Future<T?> push<T extends Object?>(BuildContext context, NotedRoute route) => Future.value();

  @override
  Future<T?> replace<T extends Object?>(BuildContext context, NotedRoute route) => Future.value();
}
