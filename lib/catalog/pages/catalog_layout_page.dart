import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/widget/common/button/noted_text_button.dart';
import 'package:noted_app/widget/common/layout/noted_card.dart';
import 'package:noted_app/widget/common/layout/noted_dialog.dart';
import 'package:noted_app/widget/common/layout/noted_loading_indicator.dart';
import 'package:noted_app/widget/common/layout/noted_snack_bar.dart';
import 'package:noted_app/widget/common/layout/noted_tab_bar.dart';
import 'package:noted_app/widget/common/noted_widget_config.dart';

class CatalogLayoutPage extends StatefulWidget {
  final List<String> tabs = ['all (20)', 'notes', 'to-do', 'climbing', 'finances'];

  CatalogLayoutPage({super.key});

  @override
  State<StatefulWidget> createState() => _CatalogLayoutPageState();
}

class _CatalogLayoutPageState extends State<CatalogLayoutPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List<CatalogListItem> children = [
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: 'loading indicator',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotedLoadingIndicator(),
            SizedBox(width: 12),
            NotedLoadingIndicator(label: 'loading text'),
          ],
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'tab bar',
        child: NotedTabBar(
          tabs: widget.tabs,
          controller: tabController,
        ),
      ),
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: 'card large',
        child: NotedCard(
          size: NotedWidgetSize.large,
          width: double.infinity,
          height: 128,
          margin: EdgeInsets.zero,
        ),
      ),
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: 'card medium',
        child: NotedCard(
          size: NotedWidgetSize.medium,
          width: double.infinity,
          height: 96,
          margin: EdgeInsets.zero,
        ),
      ),
      const CatalogListItem(
        type: CatalogListItemType.column,
        label: 'card small',
        child: NotedCard(
          size: NotedWidgetSize.small,
          width: double.infinity,
          height: 64,
          margin: EdgeInsets.zero,
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'snackbar no close',
        child: Row(
          children: [
            NotedTextButton(
              label: 'open snackbar',
              type: NotedTextButtonType.filled,
              size: NotedWidgetSize.small,
              onPressed: () => _showSnackBar(context),
            ),
            const SizedBox(width: 12),
            NotedTextButton(
              label: 'text snackbar',
              type: NotedTextButtonType.filled,
              size: NotedWidgetSize.small,
              onPressed: () => _showTextSnackBar(context),
            ),
          ],
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'snackbar with close',
        child: Row(
          children: [
            NotedTextButton(
              label: 'open snackbar',
              type: NotedTextButtonType.filled,
              size: NotedWidgetSize.small,
              onPressed: () => _showSnackBar(context, hasClose: true),
            ),
            const SizedBox(width: 12),
            NotedTextButton(
              label: 'text snackbar',
              type: NotedTextButtonType.filled,
              size: NotedWidgetSize.small,
              onPressed: () => _showTextSnackBar(context, hasClose: true),
            ),
          ],
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'dialog with title',
        child: Row(
          children: [
            NotedTextButton(
              label: 'left button',
              type: NotedTextButtonType.filled,
              size: NotedWidgetSize.small,
              onPressed: () => _showDialog(context, title: 'modal title', leftActionText: 'left action'),
            ),
            const SizedBox(width: 12),
            NotedTextButton(
              label: 'right button',
              type: NotedTextButtonType.filled,
              size: NotedWidgetSize.small,
              onPressed: () => _showDialog(context, title: 'modal title', rightActionText: 'right action'),
            ),
          ],
        ),
      ),
      CatalogListItem(
        type: CatalogListItemType.column,
        label: 'dialog no title',
        child: Row(
          children: [
            NotedTextButton(
              label: 'both buttons',
              type: NotedTextButtonType.filled,
              size: NotedWidgetSize.small,
              onPressed: () => _showDialog(context, leftActionText: 'left action', rightActionText: 'right action'),
            ),
            const SizedBox(width: 12),
            NotedTextButton(
              label: 'no buttons',
              type: NotedTextButtonType.filled,
              size: NotedWidgetSize.small,
              onPressed: () => _showDialog(context),
            ),
          ],
        ),
      ),
    ];

    return CatalogListWidget(children);
  }

  void _showSnackBar(BuildContext context, {bool hasClose = false}) {
    ThemeData theme = Theme.of(context);

    Widget content = Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'test snackbar text',
        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface),
      ),
    );

    SnackBar snackBar = hasClose
        ? NotedSnackBar.createWithClose(context: context, content: content)
        : NotedSnackBar.create(context: context, content: content);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showTextSnackBar(BuildContext context, {bool hasClose = false}) {
    SnackBar snackBar = NotedSnackBar.createWithText(
      context: context,
      text: 'test snackbar with text',
      hasClose: hasClose,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showDialog(
    BuildContext context, {
    String? title,
    String? leftActionText,
    String? rightActionText,
  }) {
    showDialog(
      context: context,
      builder: (context) => NotedDialog(
        title: title,
        leftActionText: leftActionText,
        onLeftActionPressed: () => Navigator.of(context).pop(),
        rightActionText: rightActionText,
        onRightActionPressed: () => Navigator.of(context).pop(),
        child: const Text('test dialog contents'),
      ),
    );
  }
}
