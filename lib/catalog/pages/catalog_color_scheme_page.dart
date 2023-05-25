import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/theme/theme_cubit.dart';
import 'package:noted_app/state/theme/theme_state.dart';
import 'package:noted_app/theme/color_schemes.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';

class CatalogColorSchemePage extends StatelessWidget {
  final List<NotedColorSchemeName> names = NotedColorSchemeName.values;

  const CatalogColorSchemePage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeCubit cubit = context.read<ThemeCubit>();

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) => ListView.separated(
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) => _buildThemeRow(context, names[index], state.colorSchemeName, cubit),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemCount: names.length,
      ),
    );
  }

  Widget _buildThemeRow(
    BuildContext context,
    NotedColorSchemeName name,
    NotedColorSchemeName currentName,
    ThemeCubit cubit,
  ) {
    String label = '${name.toString().replaceFirst('NotedColorSchemeName.', '')} theme';

    return ListTile(
      onTap: () => cubit.updateColorScheme(name),
      title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      trailing: name == currentName ? const Icon(NotedIcons.check) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
    );
  }
}
