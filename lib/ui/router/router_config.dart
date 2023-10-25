import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/pages/home/home_page.dart';
import 'package:noted_app/ui/pages/login/login_page.dart';
import 'package:noted_app/ui/pages/login/password_reset_page.dart';
import 'package:noted_app/ui/pages/login/register_page.dart';
import 'package:noted_app/ui/pages/login/sign_in_page.dart';
import 'package:noted_app/ui/router/route_error_page.dart';
import 'package:noted_app/ui/pages/settings/account/account_page.dart';
import 'package:noted_app/ui/pages/settings/account/change_password_page.dart';
import 'package:noted_app/ui/pages/settings/settings_page.dart';
import 'package:noted_app/ui/pages/settings/style/style_page.dart.dart';
import 'package:noted_app/ui/pages/settings/style/style_fonts_page.dart';
import 'package:noted_app/ui/pages/settings/style/style_theme_page.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_edit_page.dart';

GoRouter routerConfig = GoRouter(
  routes: [_home, _login],
  initialLocation: '/login',
  errorBuilder: (context, state) => RouteErrorPage(),
);

final GoRoute _login = GoRoute(
  path: '/login',
  builder: (context, state) => LoginPage(),
  redirect: (context, state) {
    AuthBloc auth = context.read<AuthBloc>();
    return auth.state.status == AuthStatus.authenticated ? '/' : null;
  },
  routes: [
    GoRoute(
      path: 'sign-in',
      builder: (context, state) => SignInPage(),
    ),
    GoRoute(
      path: 'register',
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      path: 'reset-password',
      builder: (context, state) => PasswordResetPage(),
    ),
  ],
);

final GoRoute _home = GoRoute(
  path: '/',
  builder: (context, state) => HomePage(),
  redirect: (context, state) {
    AuthBloc auth = context.read<AuthBloc>();
    return auth.state.status != AuthStatus.authenticated ? '/login' : null;
  },
  routes: [
    _settings,
    _notes,
  ],
);

final GoRoute _settings = GoRoute(
  path: 'settings',
  builder: (context, state) => SettingsPage(),
  routes: [
    GoRoute(
      path: 'account',
      builder: (context, state) => AccountPage(),
      routes: [
        GoRoute(
          path: 'change-password',
          builder: (context, state) => ChangePasswordPage(),
        ),
      ],
    ),
    GoRoute(
      path: 'style',
      builder: (context, state) => StylePage(),
      routes: [
        GoRoute(
          path: 'theme',
          builder: (context, state) => StyleThemePage(),
        ),
        GoRoute(
          path: 'fonts',
          builder: (context, state) => StyleFontsPage(),
        ),
      ],
    ),
    GoRoute(
      path: 'plugins',
      builder: (context, state) => SettingsPage(),
    ),
    GoRoute(
      path: 'deleted',
      builder: (context, state) => SettingsPage(),
    ),
    GoRoute(
      path: 'subscriptions',
      builder: (context, state) => SettingsPage(),
    ),
    GoRoute(
      path: 'help',
      builder: (context, state) => SettingsPage(),
    ),
  ],
);

final GoRoute _notes = GoRoute(
  path: 'notes',
  builder: (context, state) => HomePage(),
  routes: [
    GoRoute(
      path: ':noteId',
      builder: (context, state) => NotebookEditPage(noteId: state.pathParameters['noteId'] ?? ''),
    ),
  ],
);
