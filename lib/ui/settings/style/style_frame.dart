import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_app/state/settings/settings_state.dart';
import 'package:noted_app/ui/common/layout/layout.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

class StyleFrame extends StatelessWidget {
  final String title;
  final Widget Function(BuildContext, NotedStyleSettings) builder;
  final bool Function(NotedStyleSettings, NotedStyleSettings)? buildWhen;

  const StyleFrame({required this.title, required this.builder, this.buildWhen});

  @override
  Widget build(BuildContext context) {
    return NotedHeaderPage(
      title: title,
      hasBackButton: true,
      child: BlocConsumer<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) => buildWhen?.call(previous.settings.style, current.settings.style) ?? false,
        listener: (context, state) {
          if (state.error?.code == ErrorCode.settings_updateStyle_failed && context.isCurrent()) {
            ScaffoldMessenger.of(context).showSnackBar(
              NotedSnackBar.createWithText(
                context: context,
                text: context.strings().settings_error_updateFailed,
                hasClose: true,
              ),
            );
          }
        },
        builder: (context, state) => builder(context, state.settings.style),
      ),
    );
  }
}
