import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_models/noted_models.dart';

sealed class NotebookEvent extends NotedEvent implements TrackableEvent {
  const NotebookEvent();
}

class NotebookLoadNotesEvent extends NotebookEvent {}

class NotebookAddNoteEvent extends NotebookEvent {
  final NotebookNote note;

  const NotebookAddNoteEvent(this.note);
}

class NotebookUpdateNoteEvent extends NotebookEvent {
  final NotebookNote note;

  const NotebookUpdateNoteEvent(this.note);
}

class NotebookDeleteNoteEvent extends NotebookEvent {
  final String noteId;

  const NotebookDeleteNoteEvent(this.noteId);
}

class NotebookResetEvent extends NotebookEvent {}
