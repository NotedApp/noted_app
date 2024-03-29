import 'package:flutter/material.dart';
import 'package:noted_app/app.dart';
import 'package:noted_app/util/environment/prod_environment.dart';

void main() async {
  await ProdEnvironment().configure();

  runApp(const NotedApp());
}
