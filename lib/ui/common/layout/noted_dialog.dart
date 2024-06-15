import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/button/noted_text_button.dart';

class NotedDialog extends StatelessWidget {
  final String? title;
  final String? leftActionText;
  final VoidCallback? onLeftActionPressed;
  final Color? leftActionColor;
  final String? rightActionText;
  final VoidCallback? onRightActionPressed;
  final Color? rightActionColor;
  final Widget child;

  const NotedDialog({
    this.title,
    this.leftActionText,
    this.onLeftActionPressed,
    this.leftActionColor,
    this.rightActionText,
    this.onRightActionPressed,
    this.rightActionColor,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool hasTitle = title != null;
    bool hasActions = leftActionText != null || rightActionText != null;
    Widget actionRow = Container();

    if (hasActions) {
      MainAxisAlignment alignment;
      List<Widget> actions = [];

      if (leftActionText != null && rightActionText != null) {
        alignment = MainAxisAlignment.spaceBetween;

        actions.add(
          NotedTextButton(
            label: leftActionText,
            onPressed: onLeftActionPressed,
            foregroundColor: leftActionColor,
            type: NotedTextButtonType.simple,
          ),
        );

        actions.add(
          NotedTextButton(
            label: rightActionText,
            onPressed: onRightActionPressed,
            foregroundColor: rightActionColor,
            type: NotedTextButtonType.simple,
          ),
        );
      } else if (leftActionText != null) {
        alignment = MainAxisAlignment.start;

        actions.add(
          NotedTextButton(
            label: leftActionText,
            onPressed: onLeftActionPressed,
            foregroundColor: leftActionColor,
            type: NotedTextButtonType.simple,
          ),
        );
      } else {
        alignment = MainAxisAlignment.end;

        actions.add(
          NotedTextButton(
            label: rightActionText,
            onPressed: onRightActionPressed,
            foregroundColor: rightActionColor,
            type: NotedTextButtonType.simple,
          ),
        );
      }

      actionRow = Padding(
        padding: const EdgeInsets.fromLTRB(14, 6, 14, 14),
        child: Row(mainAxisAlignment: alignment, children: actions),
      );
    }

    return Dialog(
      backgroundColor: theme.colorScheme.surfaceContainer,
      elevation: 5,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.colorScheme.onSurface, width: 2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasTitle)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text(title!, style: theme.textTheme.headlineMedium),
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, hasTitle ? 0 : 20, 20, hasActions ? 0 : 20),
            child: child,
          ),
          if (hasActions) actionRow,
        ],
      ),
    );
  }
}
