import 'package:flutter/material.dart';
import 'package:noted_app/app.dart';
import 'package:noted_app/util/environment/environment.dart';

void main() async {
  Environment environment = LocalEnvironment();
  await environment.configure();

  runApp(const NotedApp());
}
