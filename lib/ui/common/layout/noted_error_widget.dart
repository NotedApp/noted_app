import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';

class NotedErrorWidget extends StatelessWidget {
  final String? title;
  final String? text;
  final String? ctaText;
  final VoidCallback? ctaCallback;

  const NotedErrorWidget({this.title, this.text, this.ctaText, this.ctaCallback});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(title!, textAlign: TextAlign.center, style: context.textTheme().displaySmall),
            ),
          if (title != null) SizedBox(height: 12),
          if (text != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(text!, textAlign: TextAlign.center),
            ),
          if (ctaCallback != null) SizedBox(height: 16),
          if (ctaCallback != null)
            Align(
              child: NotedTextButton(
                label: ctaText,
                type: NotedTextButtonType.filled,
                onPressed: ctaCallback,
              ),
            ),
        ],
      ),
    );
  }
}
