import 'package:flutter/widgets.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/environment/environment.dart';

abstract class NotedRouter {
  Future<T?> push<T extends Object?>(BuildContext context, NotedRoute route);
  Future<T?> replace<T extends Object?>(BuildContext context, NotedRoute route);
  void pop<T extends Object?>(BuildContext context, [T? result]);
  Future<T?> popAndPush<T extends Object?, U extends Object?>(BuildContext context, NotedRoute route, [U? result]);
}

extension NotedRouterExtensions on BuildContext {
  Future<T?> push<T extends Object?>(NotedRoute route) => locator<NotedRouter>().push(this, route);
  Future<T?> replace<T extends Object?>(NotedRoute route) => locator<NotedRouter>().replace(this, route);
  void pop<T extends Object?>([T? result]) => locator<NotedRouter>().pop(this, result);
  Future<T?> popAndPush<T extends Object?, U extends Object?>(NotedRoute route, [U? result]) =>
      locator<NotedRouter>().popAndPush(this, route, result);
}
