import 'package:go_router/go_router.dart';
import 'package:noted_app/app.dart';
import 'package:noted_app/ui/router/route_error_page.dart';

GoRouter routerConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MyHomePage(title: 'noted'),
    ),
  ],
  errorBuilder: (context, state) => RouteErrorPage(),
);
