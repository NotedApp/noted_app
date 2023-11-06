import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';

List<IconData> _icons = [
  NotedIcons.textColor,
  NotedIcons.text,
  NotedIcons.trash,
  NotedIcons.underline,
  NotedIcons.unorderedList,
  NotedIcons.unpinned,
  NotedIcons.video,
  NotedIcons.account,
  NotedIcons.alarmClock,
  NotedIcons.animation,
  NotedIcons.apple,
  NotedIcons.backgroundColor,
  NotedIcons.basketball,
  NotedIcons.bell,
  NotedIcons.bold,
  NotedIcons.book,
  NotedIcons.brush,
  NotedIcons.camera,
  NotedIcons.check,
  NotedIcons.chevronDown,
  NotedIcons.chevronLeft,
  NotedIcons.chevronRight,
  NotedIcons.chevronUp,
  NotedIcons.close,
  NotedIcons.coin,
  NotedIcons.creditCard,
  NotedIcons.email,
  NotedIcons.eyeClosed,
  NotedIcons.eye,
  NotedIcons.eyedropper,
  NotedIcons.facebook,
  NotedIcons.github,
  NotedIcons.google,
  NotedIcons.h1,
  NotedIcons.h2,
  NotedIcons.h3,
  NotedIcons.help,
  NotedIcons.info,
  NotedIcons.italic,
  NotedIcons.key,
  NotedIcons.link,
  NotedIcons.mic,
  NotedIcons.mountain,
  NotedIcons.orderedList,
  NotedIcons.pencil,
  NotedIcons.paw,
  NotedIcons.phone,
  NotedIcons.pinned,
  NotedIcons.pizza,
  NotedIcons.plug,
  NotedIcons.plus,
  NotedIcons.settings,
  NotedIcons.star,
  NotedIcons.stats,
  NotedIcons.strikethrough,
  NotedIcons.taskList,
  NotedIcons.tag,
];

class CatalogIconsPage extends StatelessWidget {
  const CatalogIconsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: 6,
      children: _icons.map(_buildIconSquare).toList(),
    );
  }

  Widget _buildIconSquare(IconData icon) {
    return Center(child: Icon(icon));
  }
}
