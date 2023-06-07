import 'package:flutter/material.dart';

extension MaterialProperties on Color {
  MaterialStateProperty<Color> materialState() {
    return MaterialStatePropertyAll(this);
  }
}
