import 'package:mocktail/mocktail.dart';
import 'package:noted_app/state/notes/notes_bloc.dart';
import 'package:noted_app/ui/common/noted_library.dart';
import 'package:noted_app/ui/router/noted_router.dart';

class MockRouter extends Mock implements NotedRouter {}

class MockEditorController extends Mock implements NotedEditorController {}

class MockNotesBloc extends Mock implements NotesBloc {}
