import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key});

  @override
  State<StatefulWidget> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: NotedSearchBar(controller: controller),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
