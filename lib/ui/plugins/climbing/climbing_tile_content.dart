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
        // TODO: Update this to use an enum (requires model update).
        'indoors' => strings.climbing_setting_indoors,
        'outdoors' => strings.climbing_setting_outdoors,
        _ => strings.climbing_setting_indoors,
      },
      switch (note.field(NoteField.climbingType)) {
        // TODO: Update this to use an enum (requires model update).
        'bouldering' => strings.climbing_type_boulder,
        'traditional' => strings.climbing_type_traditional,
        'sport' => strings.climbing_type_sport,
        _ => strings.climbing_type_boulder,
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
