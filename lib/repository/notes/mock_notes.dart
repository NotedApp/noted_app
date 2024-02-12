import 'package:noted_models/noted_models.dart';

/// A set of mock notes for usage in the local notes repository and testing.
class MockNotes {
  static final notebook0 = NoteModel.value(
    NotedPlugin.notebook,
    overrides: [
      const NoteFieldValue(NoteField.title, 'Notebook 0'),
      const NoteFieldValue(NoteField.document, [Document.mock]),
      const NoteFieldValue(NoteField.tagIds, ['test-tag-0']),
    ],
  ).copyWith(id: 'test-notebook-0');

  static final cookbook0 = NoteModel.value(
    NotedPlugin.cookbook,
    overrides: [
      const NoteFieldValue(NoteField.title, 'Cookbook 0'),
      const NoteFieldValue(NoteField.document, [Document.mock]),
      const NoteFieldValue(NoteField.tagIds, ['test-tag-0']),
    ],
  ).copyWith(id: 'test-cookbook-0');

  static final climbing0 = NoteModel.value(
    NotedPlugin.climbing,
    overrides: [
      const NoteFieldValue(NoteField.title, 'Climbing 0'),
      const NoteFieldValue(NoteField.document, [Document.mock]),
      const NoteFieldValue(NoteField.tagIds, ['test-tag-0']),
    ],
  ).copyWith(id: 'test-climbing-0');
}
