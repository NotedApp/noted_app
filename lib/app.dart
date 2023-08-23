import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/auth/auth_bloc.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_app/state/settings/settings_state.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

class NotedApp extends StatelessWidget {
  const NotedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => SettingsBloc()),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) {
          NotedStyleSettings old = previous.settings.style;
          NotedStyleSettings next = current.settings.style;
          return old.currentColorScheme != next.currentColorScheme || old.textTheme != next.textTheme;
        },
        builder: (context, state) {
          ColorScheme colorScheme = state.settings.style.currentColorScheme.toMaterial();
          TextTheme textTheme = state.settings.style.textTheme.toMaterial();

          return MaterialApp.router(
            onGenerateTitle: (context) => context.strings().app_title,
            localizationsDelegates: Strings.localizationsDelegates,
            supportedLocales: Strings.supportedLocales,
            routerConfig: routerConfig,
            theme: ThemeData(
              brightness: colorScheme.brightness,
              colorScheme: colorScheme,
              textTheme: textTheme,
              textButtonTheme: _createTextButtonTheme(textTheme, colorScheme),
              useMaterial3: true,
            ),
          );
        },
      ),
    );
  }
}

TextButtonThemeData _createTextButtonTheme(TextTheme text, ColorScheme colors) {
  return TextButtonThemeData(style: ButtonStyle(backgroundColor: colors.primary.materialState()));
}

extension _NotedBrightnessExtensions on NotedBrightness {
  Brightness toMaterial() {
    return switch (this) {
      NotedBrightness.light => Brightness.light,
      _ => Brightness.dark,
    };
  }
}

extension _NotedColorSchemeExtensions on NotedColorScheme {
  ColorScheme toMaterial() {
    return ColorScheme(
      brightness: brightness.toMaterial(),
      primary: Color(primary),
      onPrimary: Color(onPrimary),
      secondary: Color(secondary),
      onSecondary: Color(onSecondary),
      error: Color(error),
      onError: Color(onError),
      background: Color(background),
      onBackground: Color(onBackground),
      surface: Color(surface),
      onSurface: Color(onSurface),
    );
  }
}

extension _NotedTextThemeExtensions on NotedTextTheme {
  TextTheme toMaterial() {
    return TextTheme(
      displayLarge: TextStyle(fontFamily: fontFamily, fontSize: 57, height: 64 / 57, fontWeight: FontWeight.normal),
      displayMedium: TextStyle(fontFamily: fontFamily, fontSize: 45, height: 52 / 45, fontWeight: FontWeight.normal),
      displaySmall: TextStyle(fontFamily: fontFamily, fontSize: 36, height: 44 / 36, fontWeight: FontWeight.normal),
      headlineLarge: TextStyle(fontFamily: fontFamily, fontSize: 32, height: 40 / 32, fontWeight: FontWeight.normal),
      headlineMedium: TextStyle(fontFamily: fontFamily, fontSize: 28, height: 36 / 28, fontWeight: FontWeight.normal),
      headlineSmall: TextStyle(fontFamily: fontFamily, fontSize: 24, height: 32 / 24, fontWeight: FontWeight.normal),
      titleLarge: TextStyle(fontFamily: fontFamily, fontSize: 22, height: 28 / 22, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontFamily: fontFamily, fontSize: 18, height: 24 / 18, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontFamily: fontFamily, fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w500),
      labelLarge: TextStyle(fontFamily: fontFamily, fontSize: 14, height: 20 / 14, fontWeight: FontWeight.normal),
      labelMedium: TextStyle(fontFamily: fontFamily, fontSize: 12, height: 16 / 12, fontWeight: FontWeight.normal),
      labelSmall: TextStyle(fontFamily: fontFamily, fontSize: 11, height: 16 / 11, fontWeight: FontWeight.normal),
      bodyLarge: TextStyle(fontFamily: fontFamily, fontSize: 16, height: 24 / 16, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontFamily: fontFamily, fontSize: 14, height: 20 / 14, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontFamily: fontFamily, fontSize: 12, height: 16 / 12, fontWeight: FontWeight.normal),
    );
  }
}
