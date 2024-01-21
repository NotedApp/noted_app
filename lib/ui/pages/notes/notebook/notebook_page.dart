import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/pages/notes/common/notes_content.dart';
import 'package:noted_app/ui/pages/notes/common/notes_page.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

const NotesFilter _filter = NotesFilter(plugins: {NotedPlugin.notebook});

// coverage:ignore-file
class NotebookPage extends StatelessWidget {
  const NotebookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return BlocProvider(
      create: (context) => NotesBloc(filter: _filter),
      child: NotesPage(
        title: strings.plugin_notebook_title,
        onAdded: () => context.push(const NotesAddRoute(plugin: NotedPlugin.notebook)),
        child: const NotesContent(),
      ),
    );
  }
}
