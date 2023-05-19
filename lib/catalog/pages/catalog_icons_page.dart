import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';

class CatalogIconsPage extends StatelessWidget {
  const CatalogIconsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: 6,
      children: NotedIcons.iconList.map((icon) => _buildIconSquare(icon)).toList(),
    );
  }

  Widget _buildIconSquare(IconData icon) {
    return Center(child: Icon(icon));
  }
}