import 'package:flutter/material.dart';
import 'package:noted_app/ui/pages/notes/common/notes_content.dart';
import 'package:noted_app/ui/pages/notes/common/notes_page.dart';
import 'package:noted_app/ui/pages/notes/home/home_grid.dart';
import 'package:noted_app/ui/pages/notes/home/note_picker.dart';
import 'package:noted_app/ui/router/noted_router.dart';
import 'package:noted_app/ui/router/router_config.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

// coverage:ignore-file
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return NotesPage(
      title: strings.app_title,
      hasBackButton: false,
      onAdded: () => context.push(const NotesAddRoute(plugin: NotedPlugin.notebook)),
      onLongAdded: () => NotePicker.show(context),
      child: const NotesContent(loaded: HomeGrid()),
    );
  }
}
