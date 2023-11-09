import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef NotedBlocBuilder<B extends StateStreamable, S> = Widget Function(BuildContext context, B bloc, S state);

class NotedBlocSelector<B extends StateStreamable<S>, S, T> extends StatefulWidget {
  final B? bloc;
  final BlocWidgetSelector<S, T> selector;
  final NotedBlocBuilder<B, T> builder;
  final BlocWidgetListener<S>? listener;
  final BlocWidgetListener<T>? selectedListener;

  const NotedBlocSelector({
    required this.selector,
    required this.builder,
    this.listener,
    this.selectedListener,
    this.bloc,
    super.key,
  });

  @override
  State<NotedBlocSelector<B, S, T>> createState() => _NotedBlocSelector<B, S, T>();
}

class _NotedBlocSelector<B extends StateStreamable<S>, S, T> extends State<NotedBlocSelector<B, S, T>> {
  late B _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc ?? context.read<B>();
  }

  // coverage:ignore-start
  @override
  void didUpdateWidget(NotedBlocSelector<B, S, T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldBloc = oldWidget.bloc ?? context.read<B>();
    final currentBloc = widget.bloc ?? oldBloc;
    if (oldBloc != currentBloc) {
      _bloc = currentBloc;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bloc = widget.bloc ?? context.read<B>();
    if (_bloc != bloc) {
      _bloc = bloc;
    }
  }
  // coverage:ignore-end

  @override
  Widget build(BuildContext context) {
    if (widget.bloc == null) {
      context.select<B, bool>((bloc) => identical(_bloc, bloc));
    }

    return BlocBuilder<B, S>(
      bloc: _bloc,
      builder: (context, state) => widget.builder(context, _bloc, widget.selector(state)),
      buildWhen: (previous, current) {
        final T previousState = widget.selector(previous);
        final T currentState = widget.selector(current);
        final bool hasChanged = previousState != currentState;

        widget.listener?.call(context, current);

        if (hasChanged) {
          widget.selectedListener?.call(context, currentState);
        }

        return hasChanged;
      },
    );
  }
}
