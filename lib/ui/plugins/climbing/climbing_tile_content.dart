import 'package:flutter/material.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/util/extensions/extensions.dart';
import 'package:noted_models/noted_models.dart';

class ClimbingTileContent extends StatelessWidget {
  final NoteModel note;

  const ClimbingTileContent({required this.note, super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    final title = note.field(NoteField.title);
    final rating = note.field(NoteField.climbingRating);
    final location = note.field(NoteField.location);
    final imageUrl = note.field(NoteField.imageUrl);

    final info0 = [
      if (rating.isNotEmpty) rating,
      if (location.isNotEmpty) location,
    ].join(' • ');

    final info1 = [
      switch (note.field(NoteField.climbingSetting)) {
        ClimbingSetting.indoor => strings.climbing_setting_indoors,
        ClimbingSetting.outdoor => strings.climbing_setting_outdoors,
      },
      switch (note.field(NoteField.climbingType)) {
        ClimbingType.boulder => strings.climbing_type_boulder,
        ClimbingType.traditional => strings.climbing_type_traditional,
        ClimbingType.sport => strings.climbing_type_sport,
      }
    ].join(' • ');

    final attempts = note.field(NoteField.climbingAttemptsUtc).length;
    final tops = note.field(NoteField.climbingTopsUtc).length;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (imageUrl.isNotEmpty) NotedTileBackgroundImage(imageUrl: imageUrl),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.spacing_m),
          child: Column(
            children: [
              const Spacer(),
              if (title.isNotEmpty) NotedTileTitle(title),
              if (info0.isNotEmpty) NotedTileText(info0, fontWeight: FontWeight.w500),
              NotedTileText(info1),
              NotedTileText(strings.climbing_attempts(attempts)),
              if (tops > 0) NotedTileText(strings.climbing_tops(tops)),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
