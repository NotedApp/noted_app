import 'package:flutter/material.dart';
import 'package:noted_app/app.dart';
import 'package:noted_app/util/environment/local_environment.dart';

void main() async {
  await LocalEnvironment().configure();

  runApp(const NotedApp());
}
