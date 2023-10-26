import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/pages/edit/edit_page.dart';
import 'package:noted_app/ui/pages/home/home_page.dart';
import 'package:noted_app/ui/pages/login/login_page.dart';
import 'package:noted_app/ui/pages/login/password_reset_page.dart';
import 'package:noted_app/ui/pages/login/register_page.dart';
import 'package:noted_app/ui/pages/login/sign_in_page.dart';
import 'package:noted_app/ui/pages/settings/tags/tags_page.dart';
import 'package:noted_app/ui/router/route_error_page.dart';
import 'package:noted_app/ui/pages/settings/account/account_page.dart';
import 'package:noted_app/ui/pages/settings/account/change_password_page.dart';
import 'package:noted_app/ui/pages/settings/settings_page.dart';
import 'package:noted_app/ui/pages/settings/style/style_page.dart.dart';
import 'package:noted_app/ui/pages/settings/style/style_fonts_page.dart';
import 'package:noted_app/ui/pages/settings/style/style_theme_page.dart';

part 'noted_route.dart';

GoRouter routerConfig = GoRouter(
  routes: [_home, _login],
  initialLocation: NotedRoute._login,
  errorBuilder: (context, state) => RouteErrorPage(),
);

final GoRoute _login = GoRoute(
  path: NotedRoute._login,
  builder: (context, state) => LoginPage(),
  redirect: (context, state) {
    AuthBloc auth = context.read<AuthBloc>();
    return auth.state.status == AuthStatus.authenticated ? NotedRoute._home : null;
  },
  routes: [
    GoRoute(
      path: NotedRoute._login_signIn,
      builder: (context, state) => SignInPage(),
    ),
    GoRoute(
      path: NotedRoute._login_register,
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      path: NotedRoute._login_resetPassword,
      builder: (context, state) => PasswordResetPage(),
    ),
  ],
);

final GoRoute _home = GoRoute(
  path: NotedRoute._home,
  builder: (context, state) => HomePage(),
  redirect: (context, state) {
    AuthBloc auth = context.read<AuthBloc>();
    return auth.state.status != AuthStatus.authenticated ? NotedRoute._settings : null;
  },
  routes: [
    _settings,
    _notes,
  ],
);

final GoRoute _settings = GoRoute(
  path: NotedRoute._settings,
  builder: (context, state) => SettingsPage(),
  routes: [
    GoRoute(
      path: NotedRoute._settings_account,
      builder: (context, state) => AccountPage(),
      routes: [
        GoRoute(
          path: NotedRoute._settings_account_changePassword,
          builder: (context, state) => ChangePasswordPage(),
        ),
      ],
    ),
    GoRoute(
      path: NotedRoute._settings_style,
      builder: (context, state) => StylePage(),
      routes: [
        GoRoute(
          path: NotedRoute._settings_style_theme,
          builder: (context, state) => StyleThemePage(),
        ),
        GoRoute(
          path: NotedRoute._settings_style_fonts,
          builder: (context, state) => StyleFontsPage(),
        ),
      ],
    ),
    GoRoute(
      path: NotedRoute._settings_tags,
      builder: (context, state) => TagsPage(),
    ),
    GoRoute(
      path: NotedRoute._settings_plugins,
      builder: (context, state) => SettingsPage(),
    ),
    GoRoute(
      path: NotedRoute._settings_deleted,
      builder: (context, state) => SettingsPage(),
    ),
    GoRoute(
      path: NotedRoute._settings_subscriptions,
      builder: (context, state) => SettingsPage(),
    ),
    GoRoute(
      path: NotedRoute._settings_help,
      builder: (context, state) => SettingsPage(),
    ),
  ],
);

final GoRoute _notes = GoRoute(
  path: NotedRoute._notes,
  builder: (context, state) => HomePage(),
  routes: [
    GoRoute(
      path: NotedRoute._notes_add,
      builder: (context, state) => EditPage(initialId: null),
    ),
    GoRoute(
      path: ':${NotedRoute._notes_noteId}',
      builder: (context, state) => EditPage(initialId: state.pathParameters[NotedRoute._notes_noteId]),
    ),
  ],
);
