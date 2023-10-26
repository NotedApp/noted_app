import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_app/state/settings/settings_state.dart';
import 'package:noted_app/ui/common/layout/layout.dart';
import 'package:noted_app/ui/pages/settings/settings_page.dart';
import 'package:noted_models/noted_models.dart';

class StyleFrame extends StatelessWidget {
  final String title;
  final Widget Function(BuildContext, StyleSettingsModel) builder;
  final bool Function(StyleSettingsModel, StyleSettingsModel)? buildWhen;

  const StyleFrame({required this.title, required this.builder, this.buildWhen});

  @override
  Widget build(BuildContext context) {
    return NotedHeaderPage(
      title: title,
      hasBackButton: true,
      child: BlocConsumer<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) => buildWhen?.call(previous.settings.style, current.settings.style) ?? false,
        listener: handleSettingsError,
        builder: (context, state) => builder(context, state.settings.style),
      ),
    );
  }
}
