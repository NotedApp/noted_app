import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/button/noted_text_button.dart';

class NotedDialog extends StatelessWidget {
  final String? title;
  final String? leftActionText;
  final VoidCallback? onLeftActionPressed;
  final String? rightActionText;
  final VoidCallback? onRightActionPressed;
  final Widget child;

  const NotedDialog({
    this.title,
    this.leftActionText,
    this.onLeftActionPressed,
    this.rightActionText,
    this.onRightActionPressed,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool hasTitle = title != null;
    bool hasActions = leftActionText != null || rightActionText != null;

    List<Widget> contents = [];

    if (hasTitle) {
      contents.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          child: Text(title!, style: theme.textTheme.headlineLarge),
        ),
      );
    }

    contents.add(
      Padding(
        padding: EdgeInsets.fromLTRB(20, hasTitle ? 0 : 20, 20, hasActions ? 0 : 20),
        child: child,
      ),
    );

    if (hasActions) {
      MainAxisAlignment alignment;
      List<Widget> actions = [];

      if (leftActionText != null && rightActionText != null) {
        alignment = MainAxisAlignment.spaceBetween;

        actions.add(
          NotedTextButton(
            label: leftActionText!,
            onPressed: onLeftActionPressed,
            type: NotedTextButtonType.simple,
            size: NotedTextButtonSize.medium,
          ),
        );

        actions.add(
          NotedTextButton(
            label: rightActionText!,
            onPressed: onRightActionPressed,
            type: NotedTextButtonType.simple,
            size: NotedTextButtonSize.medium,
          ),
        );
      } else if (leftActionText != null) {
        alignment = MainAxisAlignment.start;

        actions.add(
          NotedTextButton(
            label: leftActionText!,
            onPressed: onLeftActionPressed,
            type: NotedTextButtonType.simple,
            size: NotedTextButtonSize.medium,
          ),
        );
      } else {
        alignment = MainAxisAlignment.end;

        actions.add(
          NotedTextButton(
            label: rightActionText!,
            onPressed: onRightActionPressed,
            type: NotedTextButtonType.simple,
            size: NotedTextButtonSize.medium,
          ),
        );
      }

      contents.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 14),
          child: Row(mainAxisAlignment: alignment, children: actions),
        ),
      );
    }

    return Dialog(
      backgroundColor: theme.colorScheme.surface,
      elevation: 5,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.colorScheme.onBackground, width: 2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: contents,
      ),
    );
  }
}
