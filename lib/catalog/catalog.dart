import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/catalog/catalog_content.dart';
import 'package:noted_app/catalog/catalog_renderer.dart';
import 'package:noted_app/state/theme/theme_cubit.dart';

void main() {
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
      builder: (_, state) => MaterialApp(
        title: 'noted catalog',
        theme: ThemeData(colorScheme: state.colorScheme, textTheme: state.textTheme, useMaterial3: true),
        home: Scaffold(body: SafeArea(child: CatalogRenderer(CatalogContent.content, isRoot: true))),
      ),
    );
  }
}
