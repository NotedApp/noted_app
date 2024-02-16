import 'package:flutter/material.dart';
import 'package:noted_app/app.dart';
import 'package:noted_app/util/environment/test_environment.dart';

void main() async {
  await TestEnvironment().configure();

  runApp(const NotedApp());
}
