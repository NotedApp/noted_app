import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/state/theme/theme_cubit.dart';
import 'package:noted_app/state/theme/theme_state.dart';
import 'package:noted_app/theme/text_themes.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';

class CatalogTextThemePage extends StatelessWidget {
  const CatalogTextThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeCubit cubit = context.read<ThemeCubit>();

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) => CatalogListWidget(
        NotedTextThemeName.values.map((value) => _buildThemeRow(context, value, state.textThemeName, cubit)).toList(),
      ),
    );
  }

  Widget _buildThemeRow(
    BuildContext context,
    NotedTextThemeName name,
    NotedTextThemeName currentName,
    ThemeCubit cubit,
  ) {
    String label = '${name.toString().replaceFirst('NotedTextThemeName.', '')} theme';

    return ListTile(
      onTap: () => cubit.updateTextTheme(name),
      title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      trailing: name == currentName ? const Icon(NotedIcons.check) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
    );
  }
}
