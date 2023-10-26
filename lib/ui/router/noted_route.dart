part of 'router_config.dart';

sealed class NotedRoute extends Equatable {
  static const String _login = '/login';
  static const String _login_signIn = 'sign-in';
  static const String _login_register = 'register';
  static const String _login_resetPassword = 'reset-password';

  static const String _home = '/';

  static const String _settings = 'settings';
  static const String _settings_account = 'account';
  static const String _settings_account_changePassword = 'change-password';
  static const String _settings_style = 'style';
  static const String _settings_style_theme = 'theme';
  static const String _settings_style_fonts = 'fonts';
  static const String _settings_tags = 'tags';
  static const String _settings_plugins = 'plugins';
  static const String _settings_deleted = 'deleted';
  static const String _settings_subscriptions = 'subscriptions';
  static const String _settings_help = 'help';

  static const String _notes = 'notes';
  static const String _notes_add = 'add';
  static const String _notes_noteId = 'noteId';

  String get route => (_isHomeRoute ? NotedRoute._home : '') + _parts.join('/');
  List<String> get _parts;
  bool get _isHomeRoute => true;

  const NotedRoute();

  @override
  List<Object?> get props => [_isHomeRoute, ..._parts];
}

// Login Page

class LoginRoute extends NotedRoute {
  @override
  bool get _isHomeRoute => false;

  @override
  List<String> get _parts => [
        NotedRoute._login,
      ];
}

class LoginSignInRoute extends NotedRoute {
  @override
  bool get _isHomeRoute => false;

  @override
  List<String> get _parts => [
        NotedRoute._login,
        NotedRoute._login_signIn,
      ];
}

class LoginRegisterRoute extends NotedRoute {
  @override
  bool get _isHomeRoute => false;

  @override
  List<String> get _parts => [
        NotedRoute._login,
        NotedRoute._login_register,
      ];
}

class LoginResetPasswordRoute extends NotedRoute {
  @override
  bool get _isHomeRoute => false;

  @override
  List<String> get _parts => [
        NotedRoute._login,
        NotedRoute._login_resetPassword,
      ];
}

// Home Page

class HomeRoute extends NotedRoute {
  @override
  List<String> get _parts => [];
}

// Settings Page

class SettingsRoute extends NotedRoute {
  @override
  List<String> get _parts => [
        NotedRoute._settings,
      ];
}

class SettingsAccountRoute extends NotedRoute {
  @override
  List<String> get _parts => [
        NotedRoute._settings,
        NotedRoute._settings_account,
      ];
}

class SettingsAccountChangePasswordRoute extends NotedRoute {
  @override
  List<String> get _parts => [
        NotedRoute._settings,
        NotedRoute._settings_account,
        NotedRoute._settings_account_changePassword,
      ];
}

class SettingsStyleRoute extends NotedRoute {
  @override
  List<String> get _parts => [
        NotedRoute._settings,
        NotedRoute._settings_style,
      ];
}

class SettingsStyleThemeRoute extends NotedRoute {
  @override
  List<String> get _parts => [
        NotedRoute._settings,
        NotedRoute._settings_style,
        NotedRoute._settings_style_theme,
      ];
}

class SettingsStyleFontsRoute extends NotedRoute {
  @override
  List<String> get _parts => [
        NotedRoute._settings,
        NotedRoute._settings_style,
        NotedRoute._settings_style_fonts,
      ];
}

class SettingsTagsRoute extends NotedRoute {
  @override
  List<String> get _parts => [
        NotedRoute._settings,
        NotedRoute._settings_tags,
      ];
}

class SettingsPluginsRoute extends NotedRoute {
  @override
  List<String> get _parts => [
        NotedRoute._settings,
        NotedRoute._settings_plugins,
      ];
}

class SettingsDeletedRoute extends NotedRoute {
  @override
  List<String> get _parts => [
        NotedRoute._settings,
        NotedRoute._settings_deleted,
      ];
}

class SettingsSubscriptionsRoute extends NotedRoute {
  @override
  List<String> get _parts => [
        NotedRoute._settings,
        NotedRoute._settings_subscriptions,
      ];
}

class SettingsHelpRoute extends NotedRoute {
  @override
  List<String> get _parts => [
        NotedRoute._settings,
        NotedRoute._settings_help,
      ];
}

// Notes Page

class NotesAddRoute extends NotedRoute {
  @override
  List<String> get _parts => [
        NotedRoute._notes,
        NotedRoute._notes_add,
      ];
}

class NotesEditRoute extends NotedRoute {
  final String noteId;

  const NotesEditRoute({required this.noteId});

  @override
  List<String> get _parts => [
        NotedRoute._login,
        noteId,
      ];
}
