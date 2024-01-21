import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/state/notes/notes_event.dart';
import 'package:noted_app/state/notes/notes_state.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/pages/home/home_grid.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_app/util/extensions/extensions.dart';

// coverage:ignore-file
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return NotedBlocSelector<NotesBloc, NotesState, NotesStatus>(
      selector: (state) => state.status,
      listenWhen: (previous, current) => previous.error?.code != current.error?.code,
      listener: (context, state) {
        if (state.error != null) {
          _handleError.call(context, state.error!.code);
        }
      },
      builder: (context, bloc, state) => switch (state) {
        NotesStatus.loading => const _HomeLoading(),
        NotesStatus.error => const _HomeError(),
        NotesStatus.empty => const _HomeEmpty(),
        NotesStatus.loaded => const HomeGrid(),
      },
    );
  }
}

void _handleError(BuildContext context, ErrorCode errorCode) {
  final strings = context.strings();

  switch (errorCode) {
    case ErrorCode.notes_subscribe_failed:
      ScaffoldMessenger.of(context).showSnackBar(
        NotedSnackBar.createWithText(
          context: context,
          text: strings.notes_error_failed,
          hasClose: true,
        ),
      );
    default:
  }
}

class _HomeLoading extends StatelessWidget {
  const _HomeLoading();

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

class _HomeError extends StatelessWidget {
  const _HomeError();

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final bloc = context.read<NotesBloc>();

    return NotedErrorWidget(
      text: strings.notes_error_failed,
      ctaText: strings.common_refresh,
      ctaCallback: () => bloc.add(NotesSubscribeEvent()),
    );
  }
}

class _HomeEmpty extends StatelessWidget {
  const _HomeEmpty();

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();

    return NotedErrorWidget(text: strings.notes_error_empty);
  }
}
