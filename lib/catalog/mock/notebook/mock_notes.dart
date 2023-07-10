import 'package:noted_models/noted_models.dart';

List<dynamic> _testData0 = [
  {
    'insert':
        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et 
    dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea 
    commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla 
    pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est 
    laborum.\n'''
  }
];

NotebookNote testNote0 = NotebookNote(
  id: 'test-0',
  title: '',
  document: _testData0,
);

NotebookNote testNote1 = NotebookNote(
  id: 'test-1',
  title: 'Test Note',
  document: _testData0,
);
