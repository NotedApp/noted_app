import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/auth/auth_state.dart';
import 'package:noted_app/ui/home/home_page.dart';
import 'package:noted_app/ui/login/login_page.dart';
import 'package:noted_app/ui/login/password_reset_page.dart';
import 'package:noted_app/ui/login/register_page.dart';
import 'package:noted_app/ui/login/sign_in_page.dart';
import 'package:noted_app/ui/router/route_error_page.dart';
import 'package:noted_app/ui/settings/account/account_page.dart';
import 'package:noted_app/ui/settings/account/change_password_page.dart';
import 'package:noted_app/ui/settings/settings_page.dart';
import 'package:noted_app/ui/settings/style/style_page.dart.dart';
import 'package:noted_app/ui/settings/style/update_fonts_page.dart';
import 'package:noted_app/ui/settings/style/update_theme_page.dart';

GoRouter routerConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
      redirect: (context, state) {
        AuthBloc auth = context.read<AuthBloc>();
        return auth.state.status != AuthStatus.authenticated ? '/login' : null;
      },
      routes: [
        GoRoute(
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
                  builder: (context, state) => UpdateThemePage(),
                ),
                GoRoute(
                  path: 'fonts',
                  builder: (context, state) => UpdateFontsPage(),
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
        ),
      ],
    ),
    GoRoute(
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
    ),
  ],
  initialLocation: '/login',
  errorBuilder: (context, state) => RouteErrorPage(),
);
