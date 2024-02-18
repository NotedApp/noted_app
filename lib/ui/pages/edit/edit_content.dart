import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/state/edit/edit_bloc.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/plugins/cookbook/cookbook_edit_content.dart';
import 'package:noted_app/ui/plugins/notebook/notebook_edit_content.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class EditContent extends StatelessWidget {
  const EditContent({super.key});

  @override
  Widget build(BuildContext context) {
    final plugin = context.select<EditBloc, NotedPlugin?>((bloc) => bloc.state.note?.plugin);

    if (plugin == null) {
      return _ErrorContent();
    }

    return switch (plugin) {
      NotedPlugin.notebook => const NotebookEditContent(),
      NotedPlugin.cookbook => const CookbookEditContent(),
      // TODO: Update this to climbing edit content.
      NotedPlugin.climbing => const Center(child: CircularProgressIndicator()),
    };
  }
}

class _ErrorContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Strings strings = context.strings();
    return NotedErrorWidget(
      text: strings.edit_error_empty,
      ctaText: strings.router_errorCta,
      ctaCallback: () => context.pop(),
    );
  }
}
