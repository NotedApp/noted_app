import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';

class NotedSwitchButton extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const NotedSwitchButton({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colors = theme.colorScheme;

    Color activeColor = theme.brightness == Brightness.dark ? colors.onSurface : colors.tertiary;
    Color inactiveColor = theme.brightness == Brightness.dark ? colors.primary : colors.secondary;

    final WidgetStateProperty<Icon?> thumbIcon = WidgetStateProperty.resolveWith<Icon?>(
      (Set<WidgetState> states) => states.contains(WidgetState.selected)
          ? Icon(NotedIcons.check, color: activeColor)
          : Icon(NotedIcons.close, color: inactiveColor),
    );

    return Switch(
      value: value,
      onChanged: onChanged,
      thumbIcon: thumbIcon,
      thumbColor: colors.surface.widgetState(),
      activeTrackColor: activeColor,
      inactiveTrackColor: inactiveColor,
      trackOutlineColor: Colors.transparent.widgetState(),
    );
  }
}
