import 'package:go_router/go_router.dart';
import 'package:noted_app/app.dart';

GoRouter routerConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MyHomePage(title: 'noted'),
    ),
  ],
);
