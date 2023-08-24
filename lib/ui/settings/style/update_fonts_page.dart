import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_app/state/settings/settings_event.dart';
import 'package:noted_app/state/settings/settings_state.dart';
import 'package:noted_app/ui/common/icon/noted_icons.dart';
import 'package:noted_app/ui/common/layout/noted_card.dart';
import 'package:noted_app/ui/common/layout/noted_header_page.dart';
import 'package:noted_app/ui/common/noted_widget_config.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

class UpdateFontsPage extends StatelessWidget {
  List<NotedTextThemeName> get names => NotedTextThemeName.values;

  const UpdateFontsPage({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsBloc bloc = context.read<SettingsBloc>();
    Strings strings = context.strings();

    return NotedHeaderPage(
      title: strings.settings_style_fontsTitle,
      hasBackButton: true,
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 128),
          itemBuilder: (context, index) {
            NotedTextTheme theme = NotedTextTheme.fromName(names[index]);
            TextTheme font = theme.toMaterial();

            return FontSwitcherItem(
              title: _getThemeName(strings, names[index]),
              font: font,
              isSelected: state.settings.style.textTheme == theme,
              onTap: () => bloc.add(SettingsUpdateStyleTextThemeEvent(theme)),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: names.length,
        ),
      ),
    );
  }

  String _getThemeName(Strings strings, NotedTextThemeName name) {
    return switch (name) {
      NotedTextThemeName.poppins => strings.settings_style_poppins,
      NotedTextThemeName.roboto => strings.settings_style_roboto,
      NotedTextThemeName.lora => strings.settings_style_lora,
      NotedTextThemeName.vollkorn => strings.settings_style_vollkorn,
    };
  }
}

class FontSwitcherItem extends StatelessWidget {
  final String title;
  final TextTheme font;
  final bool isSelected;
  final VoidCallback? onTap;

  const FontSwitcherItem({
    required this.title,
    required this.font,
    this.isSelected = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NotedCard(
      size: NotedWidgetSize.medium,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 16, 18),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: font.displayMedium),
                const SizedBox(height: 8),
                Text(title, style: font.headlineMedium),
                const SizedBox(height: 8),
                Text(title, style: font.bodyMedium),
              ],
            ),
            if (isSelected)
              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Icon(NotedIcons.check, size: 36),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
