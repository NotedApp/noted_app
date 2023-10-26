import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/settings/settings_bloc.dart';
import 'package:noted_app/state/settings/settings_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/settings/settings_page.dart';
import 'package:noted_app/ui/pages/settings/tags/tags_loading.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_models/noted_models.dart';

class TagsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotedHeaderPage(
      title: context.strings().settings_tags_title,
      hasBackButton: true,
      child: BlocConsumer<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) => previous.settings.tag != current.settings.tag,
        listener: handleSettingsError,
        builder: (context, state) => switch (state) {
          SettingsState(status: SettingsStatus.loading) => TagsLoading(),
          SettingsState(settings: SettingsModel(tag: TagSettingsModel(tags: const {}))) =>
            NotedErrorWidget(text: context.strings().settings_error_tags_empty),
          _ => Container(), // content
        },
      ),
    );
  }
}
