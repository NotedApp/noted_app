import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:noted_app/util/routing/noted_router.dart';

class NotedGoRouter extends NotedRouter {
  @override
  Future<T?> push<T extends Object?>(BuildContext context, String route) => GoRouter.of(context).push(route);

  @override
  Future<T?> replace<T extends Object?>(BuildContext context, String route) =>
      GoRouter.of(context).pushReplacement(route);

  @override
  void pop<T extends Object?>(BuildContext context, [T? result]) {
    if (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop(result);
    }
  }
}
