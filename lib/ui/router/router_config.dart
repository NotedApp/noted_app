import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noted_app/app.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/login/login_page.dart';
import 'package:noted_app/ui/router/route_error_page.dart';

GoRouter routerConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MyHomePage(title: 'noted'),
      redirect: (context, state) {
        AuthBloc auth = context.read<AuthBloc>();
        return auth.state.status != AuthStatus.authenticated ? '/login' : null;
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
      routes: [
        GoRoute(
          path: 'sign-in',
          builder: (context, state) => MyHomePage(title: 'noted'),
        ),
        GoRoute(
          path: 'register',
          builder: (context, state) => MyHomePage(title: 'noted'),
        ),
      ],
      redirect: (context, state) {
        AuthBloc auth = context.read<AuthBloc>();
        return auth.state.status == AuthStatus.authenticated ? '/' : null;
      },
    ),
  ],
  initialLocation: '/login',
  errorBuilder: (context, state) => RouteErrorPage(),
);
