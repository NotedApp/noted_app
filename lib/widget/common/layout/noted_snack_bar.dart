import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/button/noted_icon_button.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';
import 'package:noted_app/widget/common/noted_widget_config.dart';

class NotedSnackBar {
  static SnackBar create({required BuildContext context, required Widget content}) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return SnackBar(
      content: content,
      behavior: SnackBarBehavior.floating,
      backgroundColor: colors.background,
      elevation: 3,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colors.onBackground, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static SnackBar createWithClose({required BuildContext context, required Widget content}) {
    NotedIconButton closeButton = NotedIconButton(
      icon: NotedIcons.close,
      type: NotedIconButtonType.simple,
      size: NotedWidgetSize.small,
      onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
    );

    Row contentRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        content,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: closeButton,
        ),
      ],
    );

    return create(context: context, content: contentRow);
  }

  static SnackBar createWithText({required BuildContext context, required String text, bool hasClose = false}) {
    ThemeData theme = Theme.of(context);

    Widget content = Padding(
      padding: const EdgeInsets.all(16),
      child: Text(text, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface)),
    );

    return hasClose ? createWithClose(context: context, content: content) : create(context: context, content: content);
  }
}
