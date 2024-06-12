import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_app/ui/router/noted_router.dart';

// TODO: Get colors from style settings bloc.
final List<Color> _colors = [
  Colors.black,
  Colors.white,
  Colors.grey.shade400,
  Colors.grey.shade600,
  Colors.blueGrey.shade500,
  Colors.red.shade500,
  Colors.indigo.shade500,
  Colors.teal.shade500,
  Colors.lightGreen.shade500,
  Colors.orange.shade500,
  Colors.brown.shade500,
  Colors.blueGrey.shade200,
  Colors.red.shade200,
  Colors.purple.shade200,
  Colors.indigo.shade200,
  Colors.lightBlue.shade200,
  Colors.teal.shade200,
  Colors.lightGreen.shade200,
  Colors.yellow.shade200,
  Colors.orange.shade200,
];

class NotedColorPicker extends StatefulWidget {
  final Color initialColor;
  final String? title;
  final VoidCallback? onResetDefault;

  const NotedColorPicker({
    required this.initialColor,
    this.title,
    this.onResetDefault,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _NotedColorPickerState();
}

class _NotedColorPickerState extends State<NotedColorPicker> {
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    Strings strings = context.strings();
    VoidCallback? resetDefault = widget.onResetDefault;

    return NotedDialog(
      title: widget.title,
      leftActionText: strings.common_confirm,
      onLeftActionPressed: () => context.pop(selectedColor),
      rightActionText: strings.common_cancel,
      onRightActionPressed: () => context.pop(),
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: 6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            shrinkWrap: true,
            children: _colors
                .map(
                  (color) => NotedColorPickerButton(
                    color: color,
                    colors: colors,
                    isSelected: color == selectedColor,
                    onPressed: () => setState(() => selectedColor = color),
                  ),
                )
                .toList(),
          ),
          if (resetDefault != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: SizedBox(
                width: double.infinity,
                child: NotedTextButton(
                  label: strings.settings_style_colorDefault,
                  type: NotedTextButtonType.outlined,
                  size: NotedWidgetSize.small,
                  onPressed: () {
                    resetDefault();
                    context.pop();
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class NotedColorPickerButton extends StatelessWidget {
  final Color color;
  final ColorScheme colors;
  final bool isSelected;
  final VoidCallback onPressed;

  const NotedColorPickerButton({
    required this.color,
    required this.colors,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          iconColor: color.getBW().widgetState(),
          overlayColor: color.getBW().withOpacity(NotedWidgetConfig.buttonOverlayOpacity).widgetState(),
          backgroundColor: color.widgetState(),
          iconSize: 28.toDouble().widgetState(),
          padding: EdgeInsets.zero.widgetState(),
          shape: CircleBorder(side: BorderSide(color: colors.onBackground)).widgetState(),
        ),
        child: isSelected ? const Center(child: Icon(NotedIcons.check)) : null,
      ),
    );
  }
}

Future<Color?> showColorPicker(BuildContext context, Color initialColor, VoidCallback? onResetDefault) {
  return showDialog(
    context: context,
    builder: (_) => NotedColorPicker(
      initialColor: initialColor,
      onResetDefault: onResetDefault,
    ),
  );
}
