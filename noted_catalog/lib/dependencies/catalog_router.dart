import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';

class CatalogRouter extends NotedRouter {
  @override
  Future<T?> push<T extends Object?>(BuildContext context, NotedRoute route) =>
      _showModal(context, 'pushed route: ${route.route}');

  @override
  Future<T?> replace<T extends Object?>(BuildContext context, NotedRoute route) =>
      _showModal(context, 'replaced route with: ${route.route}');

  Future<T?> _showModal<T extends Object?>(BuildContext context, String text) {
    ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(context);

    if (messenger != null) {
      messenger.showSnackBar(NotedSnackBar.createWithText(context: context, text: text, hasClose: true));
    }

    return Future<T>.value();
  }

  @override
  void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.of(context).maybePop(result);
  }

  @override
  Future<T?> popAndPush<T extends Object?, U extends Object?>(BuildContext context, NotedRoute route, [U? result]) =>
      _showModal(context, 'popped and pushed route: ${route.route}');
}
