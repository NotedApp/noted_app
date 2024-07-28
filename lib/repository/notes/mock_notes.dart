import 'package:noted_models/noted_models.dart';

/// A set of mock notes for usage in the local notes repository and testing.
class MockNotes {
  static final note0 = noteTemplate
      .copyWith(id: 'test-note-0', defaultFields: const NoteDefaultFields(document: Document.mock))
      .updateField<String>(CommonField.title, 'Note 0');

  static final recipe0 = recipeTemplate
      .copyWith(id: 'test-recipe-0', defaultFields: const NoteDefaultFields(document: Document.mock))
      .updateField<String>(CommonField.title, 'Recipe 0')
      .updateField<Duration>(RecipeField.prepTime, const Duration(minutes: 10))
      .updateField<Duration>(RecipeField.cookTime, const Duration(minutes: 20));
}
