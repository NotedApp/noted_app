import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions.dart';
import 'package:shimmer/shimmer.dart';

class NotebookLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme();

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Shimmer.fromColors(
        baseColor: theme.shimmerBase(),
        highlightColor: theme.shimmerHighlight(),
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: List.filled(8, NotedLoadingTile()),
        ),
      ),
    );
  }
}
