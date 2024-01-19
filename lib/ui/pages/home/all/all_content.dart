import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/ui/pages/home/home_frame.dart';

class AllContent extends StatelessWidget {
  const AllContent() : super(key: const ValueKey('all'));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc(page: 'all'),
      child: const HomeFrame(),
    );
  }
}
