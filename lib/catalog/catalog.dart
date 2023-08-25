import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/catalog/catalog_content.dart';
import 'package:noted_app/catalog/catalog_renderer.dart';
import 'package:noted_app/catalog/dependencies/catalog_environment.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_app/ui/common/layout/noted_theme_builder.dart';

void main() {
  CatalogEnvironment().configure();
  runApp(const CatalogApp());
}

class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsBloc()),
      ],
      child: NotedThemeBuilder(
        builder: (context, theme) => MaterialApp(
          title: 'noted catalog',
          localizationsDelegates: Strings.localizationsDelegates,
          supportedLocales: Strings.supportedLocales,
          theme: theme,
          home: CatalogRenderer(CatalogContent.content, isRoot: true),
        ),
      ),
    );
  }
}
