import 'package:noted_models/noted_models.dart';

List<dynamic> _testData0 = [
  {
    'insert':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n'
  }
];

NotebookNoteModel testNote0 = NotebookNoteModel(
  id: 'test-0',
  title: '',
  hidden: false,
  document: _testData0,
  tagIds: {'test'},
);

NotebookNoteModel testNote1 = NotebookNoteModel(
  id: 'test-1',
  title: 'Test Note 1',
  hidden: false,
  document: _testData0,
);

NotebookNoteModel testNote2 = NotebookNoteModel(
  id: 'test-2',
  title: 'Test Note 2',
  hidden: false,
  document: _testData0,
  tagIds: {'test'},
);
