import 'package:flutter/material.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';

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

    final MaterialStateProperty<Icon?> thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) => states.contains(MaterialState.selected)
          ? Icon(NotedIcons.check, color: theme.brightness == Brightness.dark ? colors.primary : colors.tertiary)
          : Icon(NotedIcons.close, color: colors.secondary),
    );

    return Switch(
      value: value,
      onChanged: onChanged,
      thumbIcon: thumbIcon,
      thumbColor: MaterialStateProperty.all(colors.background),
      activeTrackColor: theme.brightness == Brightness.dark ? colors.onBackground : colors.tertiary,
      inactiveTrackColor: theme.brightness == Brightness.dark ? colors.primary : colors.secondary,
      trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
    );
  }
}
