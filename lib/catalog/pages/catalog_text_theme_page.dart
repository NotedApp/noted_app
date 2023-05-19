import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/state/theme/theme_cubit.dart';
import 'package:noted_app/theme/text_themes.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';
import 'package:noted_app/widget/common/layout/tappable_row.dart';

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
    List<Widget> children = [Text(label, style: Theme.of(context).textTheme.bodyLarge)];

    if (name == currentName) {
      children.add(const Icon(NotedIcons.check));
    }

    return TappableRow(
      onTap: () => cubit.updateTextTheme(name),
      children: children,
    );
  }
}
