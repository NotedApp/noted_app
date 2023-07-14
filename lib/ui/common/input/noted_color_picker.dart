import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noted_app/theme/custom_colors.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:noted_app/ui/common/button/noted_text_button.dart';
import 'package:noted_app/ui/common/icon/noted_icons.dart';
import 'package:noted_app/ui/common/layout/noted_dialog.dart';
import 'package:noted_app/ui/common/noted_widget_config.dart';
import 'package:noted_app/util/routing/noted_router.dart';

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
    Strings strings = Strings.of(context);
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
            children: customColors
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
                  label: strings.settings_colorDefault,
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
          iconColor: color.getBW().materialState(),
          overlayColor: color.getBW().withOpacity(buttonOverlayOpacity).materialState(),
          backgroundColor: color.materialState(),
          iconSize: 28.toDouble().materialState(),
          padding: EdgeInsets.zero.materialState(),
          shape: CircleBorder(side: BorderSide(color: colors.onBackground)).materialState(),
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
