import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/button/noted_icon_button.dart';
import 'package:noted_app/ui/common/icon/noted_icons.dart';
import 'package:noted_app/ui/common/noted_widget_config.dart';
import 'package:noted_app/util/extensions.dart';

class NotedSnackBar {
  static SnackBar create({required BuildContext context, required Widget content}) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return SnackBar(
      content: content,
      behavior: SnackBarBehavior.floating,
      backgroundColor: colors.surface,
      elevation: 3,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colors.onBackground, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static SnackBar createWithClose({
    required BuildContext context,
    required Widget content,
    VoidCallback? onClose,
  }) {
    NotedIconButton closeButton = NotedIconButton(
      icon: NotedIcons.close,
      type: NotedIconButtonType.simple,
      size: NotedWidgetSize.small,
      onPressed: onClose ?? () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
    );

    Row contentRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: content),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: closeButton,
        ),
      ],
    );

    return create(context: context, content: contentRow);
  }

  static SnackBar createWithText({
    required BuildContext context,
    required String text,
    bool hasClose = false,
    VoidCallback? onClose,
  }) {
    ThemeData theme = Theme.of(context);

    Widget content = Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
    );

    return hasClose
        ? createWithClose(
            context: context,
            content: content,
            onClose: onClose,
          )
        : create(
            context: context,
            content: content,
          );
  }
}

void showUnimplementedSnackBar(BuildContext context) {
  ScaffoldMessengerState? state = ScaffoldMessenger.maybeOf(context);

  state?.showSnackBar(
    NotedSnackBar.createWithText(
      context: context,
      text: context.strings().common_unimplemented,
      hasClose: true,
    ),
  );
}
