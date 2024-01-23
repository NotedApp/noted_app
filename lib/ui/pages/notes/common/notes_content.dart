import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_event.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/notes/common/notes_grid.dart';
import 'package:noted_app/util/extensions/extensions.dart';

// coverage:ignore-file
class NotesContent extends StatelessWidget {
  final Widget? loading;
  final Widget? error;
  final Widget? empty;
  final Widget? loaded;

  const NotesContent({this.loading, this.error, this.empty, this.loaded, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NotesBloc, NotesState, NotesStatus>(
      selector: (state) => state.status,
      builder: (context, state) => switch (state) {
        NotesStatus.loading => loading ?? const _NotesLoading(),
        NotesStatus.error => error ?? const _NotesError(),
        NotesStatus.empty => empty ?? const _NotesEmpty(),
        NotesStatus.loaded => loaded ?? const NotesGrid(),
      },
    );
  }
}

class _NotesLoading extends StatelessWidget {
  const _NotesLoading();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: LoadingProvider(
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: NotedWidgetConfig.tileAspectRatio,
          children: List.filled(8, const LoadingBox()),
        ),
      ),
    );
  }
}

class _NotesError extends StatelessWidget {
  const _NotesError();

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final bloc = context.read<NotesBloc>();

    return NotedErrorWidget(
      text: strings.notes_error_failed,
      ctaText: strings.common_refresh,
      ctaCallback: () => bloc.add(const NotesSubscribeEvent()),
    );
  }
}

class _NotesEmpty extends StatelessWidget {
  const _NotesEmpty();

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return NotedErrorWidget(text: strings.notes_error_empty);
  }
}
