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
      if (_timer?.isActive ?? false) {
        return;
      }

      action.call();
      _timer = Timer(this.interval, () {});
    } else {
      _timer?.cancel();
      _timer = Timer(this.interval, action);
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}
