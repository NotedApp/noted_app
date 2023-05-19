import 'package:flutter/material.dart';
import 'package:noted_app/catalog/catalog_list_widget.dart';
import 'package:noted_app/widget/common/button/noted_text_button.dart';
import 'package:noted_app/widget/common/icon/noted_icons.dart';

class CatalogTextButtonPage extends StatelessWidget {
  const CatalogTextButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    List<Widget> children = [
      const TextButtonRow(
        label: 'filled large',
        type: NotedTextButtonType.filled,
        size: NotedTextButtonSize.large,
      ),
      const TextButtonRow(
        label: 'filled large icon',
        type: NotedTextButtonType.filled,
        size: NotedTextButtonSize.large,
        icon: NotedIcons.pencil,
      ),
      TextButtonRow(
        label: 'filled medium',
        type: NotedTextButtonType.filled,
        size: NotedTextButtonSize.medium,
        foregroundColor: colors.onSecondary,
        backgroundColor: colors.secondary,
      ),
      TextButtonRow(
        label: 'filled medium icon',
        type: NotedTextButtonType.filled,
        size: NotedTextButtonSize.medium,
        foregroundColor: colors.onSecondary,
        backgroundColor: colors.secondary,
        icon: NotedIcons.pencil,
      ),
      TextButtonRow(
        label: 'filled small',
        type: NotedTextButtonType.filled,
        size: NotedTextButtonSize.small,
        foregroundColor: colors.onTertiary,
        backgroundColor: colors.tertiary,
      ),
      TextButtonRow(
        label: 'filled small icon',
        type: NotedTextButtonType.filled,
        size: NotedTextButtonSize.small,
        foregroundColor: colors.onTertiary,
        backgroundColor: colors.tertiary,
        icon: NotedIcons.pencil,
      ),
      const TextButtonRow(
        label: 'outlined large',
        type: NotedTextButtonType.outlined,
        size: NotedTextButtonSize.large,
      ),
      const TextButtonRow(
        label: 'outlined large icon',
        type: NotedTextButtonType.outlined,
        size: NotedTextButtonSize.large,
        icon: NotedIcons.pencil,
      ),
      const TextButtonRow(
        label: 'outlined medium',
        type: NotedTextButtonType.outlined,
        size: NotedTextButtonSize.medium,
      ),
      const TextButtonRow(
        label: 'outlined medium icon',
        type: NotedTextButtonType.outlined,
        size: NotedTextButtonSize.medium,
        icon: NotedIcons.pencil,
      ),
      const TextButtonRow(
        label: 'outlined small',
        type: NotedTextButtonType.outlined,
        size: NotedTextButtonSize.small,
      ),
      const TextButtonRow(
        label: 'outlined small icon',
        type: NotedTextButtonType.outlined,
        size: NotedTextButtonSize.small,
        icon: NotedIcons.pencil,
      ),
      const TextButtonRow(
        label: 'simple large',
        type: NotedTextButtonType.simple,
        size: NotedTextButtonSize.large,
      ),
      const TextButtonRow(
        label: 'simple large icon',
        type: NotedTextButtonType.simple,
        size: NotedTextButtonSize.large,
        icon: NotedIcons.pencil,
      ),
      const TextButtonRow(
        label: 'simple medium',
        type: NotedTextButtonType.simple,
        size: NotedTextButtonSize.medium,
      ),
      const TextButtonRow(
        label: 'simple medium icon',
        type: NotedTextButtonType.simple,
        size: NotedTextButtonSize.medium,
        icon: NotedIcons.pencil,
      ),
      const TextButtonRow(
        label: 'simple small',
        type: NotedTextButtonType.simple,
        size: NotedTextButtonSize.small,
      ),
      const TextButtonRow(
        label: 'simple small icon',
        type: NotedTextButtonType.simple,
        size: NotedTextButtonSize.small,
        icon: NotedIcons.pencil,
      ),
    ];

    return CatalogListWidget(children);
  }
}

class TextButtonRow extends StatelessWidget {
  final String label;
  final NotedTextButtonType type;
  final NotedTextButtonSize size;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final IconData? icon;

  const TextButtonRow({
    required this.label,
    required this.type,
    required this.size,
    this.foregroundColor,
    this.backgroundColor,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NotedTextButton(
          label: 'noted',
          type: type,
          size: size,
          icon: icon,
          onPressed: () => {},
          onLongPress: () => {},
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
        ),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
