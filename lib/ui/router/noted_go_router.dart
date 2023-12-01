import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions.dart';

class NotedGoRouter extends NotedRouter {
  @override
  Future<T?> push<T extends Object?>(BuildContext context, NotedRoute route) =>
      context.isCurrent() ? GoRouter.of(context).push(route.route) : Future.value();

  @override
  Future<T?> replace<T extends Object?>(BuildContext context, NotedRoute route) =>
      context.isCurrent() ? GoRouter.of(context).pushReplacement(route.route) : Future.value();

  @override
  void pop<T extends Object?>(BuildContext context, [T? result]) {
    if (context.isCurrent() && GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop(result);
    }
  }

  @override
  Future<T?> popAndPush<T extends Object?, U extends Object?>(BuildContext context, NotedRoute route, [U? result]) {
    pop(context, result);
    return GoRouter.of(context).push(route.route);
  }
}
