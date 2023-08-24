import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions.dart';

class NotedApp extends StatelessWidget {
  const NotedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => SettingsBloc()),
      ],
      child: NotedThemeBuilder(
        builder: (context, theme) => MaterialApp.router(
          onGenerateTitle: (context) => context.strings().app_title,
          localizationsDelegates: Strings.localizationsDelegates,
          supportedLocales: Strings.supportedLocales,
          routerConfig: routerConfig,
          theme: theme,
        ),
      ),
    );
  }
}
