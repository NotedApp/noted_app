import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/pages/home/home_frame.dart';
import 'package:noted_models/noted_models.dart';

class CookbookContent extends StatelessWidget {
  const CookbookContent() : super(key: const ValueKey('cookbook'));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc(
        page: 'cookbook',
        filter: const NotesFilter(plugins: {NotedPlugin.cookbook}),
      ),
      child: const HomeFrame(),
    );
  }
}
