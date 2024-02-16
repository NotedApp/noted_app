import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration interval;
  final bool runFirst;
  Timer? _timer;

  bool get isActive => _timer?.isActive ?? false;

  Debouncer({required this.interval, this.runFirst = false});

  void run(VoidCallback action) {
    if (runFirst) {
      if (isActive) {
        return;
      }

      action.call();
      _timer = Timer(interval, _run);
    } else {
      _timer?.cancel();
      _timer = Timer(interval, () => _run(action: action));
    }
  }

  void dispose() {
    _timer?.cancel();
  }

  void _run({VoidCallback? action}) {
    action?.call();
  }
}
