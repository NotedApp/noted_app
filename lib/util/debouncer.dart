import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration interval;
  final bool runFirst;
  late final StreamController<bool> _isActiveController = StreamController.broadcast(
    onListen: () => _isActiveController.add(isActive),
  );
  Timer? _timer;

  bool get isActive => _timer?.isActive ?? false;
  Stream<bool> get activeStream => _isActiveController.stream;

  Debouncer({required this.interval, this.runFirst = false});

  void run(VoidCallback action) {
    if (runFirst) {
      if (isActive) {
        return;
      }

      action.call();
      _timer = Timer(this.interval, _cancel);
      _isActiveController.add(true);
    } else {
      _timer?.cancel();
      _isActiveController.add(true);
      _timer = Timer(this.interval, () => _cancel(action: action));
    }
  }

  void dispose() {
    _isActiveController.close();
    _timer?.cancel();
  }

  void _cancel({VoidCallback? action}) {
    if (!_isActiveController.isClosed) {
      _isActiveController.add(false);
      action?.call();
    }
  }
}
