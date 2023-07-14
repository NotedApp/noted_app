import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/catalog/catalog_content.dart';
import 'package:noted_app/catalog/catalog_renderer.dart';
import 'package:noted_app/catalog/dependencies/catalog_environment.dart';
import 'package:noted_app/state/theme/theme_cubit.dart';
import 'package:noted_app/state/theme/theme_state.dart';

void main() {
  CatalogEnvironment().configure();
  runApp(const CatalogApp());
}

class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: const CatalogAppView(),
    );
  }
}

class CatalogAppView extends StatelessWidget {
  const CatalogAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) => MaterialApp(
        title: 'noted catalog',
        localizationsDelegates: Strings.localizationsDelegates,
        supportedLocales: Strings.supportedLocales,
        theme: state.themeData,
        home: CatalogRenderer(CatalogContent.content, isRoot: true),
      ),
    );
  }
}
